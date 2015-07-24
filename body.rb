class BathAndBodyWorks < StoreAPI
  class << self

    DOMAIN = 'http://www.bathandbodyworks.com/'
    PRODUCT_KEY_PREFIX = 'bath_and_body_works_'

    AJAX_API = "http://www.bathandbodyworks.com/family/p2p-ajax-retrieve.jsp?pageType=family&%%CAT_PARAM%%&showAddToBag=true&undefined&ajaxStart=%%START%%&ajaxEnd=%%END%%&ajaxType=medLarge&viewType=grid&loadMoreClicked=1&productCounterStart=%%START%%&ppg=1000"
    
    def store_items
      @store  = Store.where(name: "Bath and Body Works").last
      @categories = @store.categories.external.where.not(url: nil)
      created_at = DateTime.now
      Watir.default_timeout = 90
      cat_b = Watir::Browser.new(:phantomjs)
      @categories.each do |category|        
        items = []
        cat_b.goto category.url
        cat_doc = Nokogiri::HTML(cat_b.html)
        
        prod_urls = get_prod_urls(cat_doc)
        
        total_item_cnt = get_total_item_cnt(cat_doc)
        total_page = (total_item_cnt / 48.0).ceil

        cur_page = 1
        while cur_page < total_page 
          cur_page = cur_page + 1

          break unless load_more_tag = cat_b.div(id: 'familyLoadMore').present? && load_more_tag = cat_b.div(id: 'familyLoadMore').visible?

          cat_b.execute_script("$('.grid-row').remove();")
          cat_b.a(href: '#load-more').click
          
          unless cur_page == total_page
            Watir::Wait.until{ 
              cat_b.elements(xpath: '//div[@class="thumbnail"]/a').present? && cat_b.elements(xpath: '//div[@class="thumbnail"]/a').count == 48 
            }
          else
            rm_cnt = total_item_cnt - (total_page-1) * 48           
            if total_item_cnt > 0
              Watir::Wait.until { 
                puts "#{cat_b.elements(xpath: '//div[@class="thumbnail"]/a').count}  #{rm_cnt}"
                cat_b.elements(xpath: '//div[@class="thumbnail"]/a').present? && cat_b.elements(xpath: '//div[@class="thumbnail"]/a').count == rm_cnt
              }
            end
          end          
          cat_doc = Nokogiri::HTML(cat_b.html)
          # total_item_cnt = get_total_item_cnt(cat_doc)

          page_prod_urls = get_prod_urls(cat_doc)
          prod_urls = prod_urls | page_prod_urls
        end
        puts "#{category.name} Total: #{total_item_cnt}, Check: #{prod_urls.count}"
        # prod_urls.each do |prod_url|
        #   prod_infos = get_prod_infos(prod_url)          
        #   next unless prod_infos.present?
        #   items << prod_infos[:items] if prod_infos[:items].present?
        # end
        # create_items(items.flatten, @store, category, created_at)        
      end
      close_browser(cat_b)
      complete_item_creation(@store)
    end

    def has_more_info
      true
    end

    def get_total_item_cnt(cat_doc)
      total_cnt = cat_doc.xpath('//span[@class="loadMoreTotal"]').try(:text)
      total_cnt.to_i rescue 0
    end

    
    def get_prod_urls(cat_doc)      
      cat_doc.xpath('//div[@class="thumbnail"]/a/@href').map(&:text)
    end

    def get_prod_infos(prod_url)
      begin        
        b = Watir::Browser.new(:phantomjs)          
        b.goto prod_url
        product_doc = Nokogiri::HTML(b.html)
        
        if b.p(id: "item_out_of_stock").present?
          close_browser(b)
          return {}
        end

        name = product_doc.xpath('//div[contains(@class, "product_column_2")]/h1').text.strip
        desc = product_doc.xpath('//div[@class="product_description"]').text.strip
        
        was_price_tag = product_doc.xpath('//li[contains(@class,"was_price")]/span')
        if was_price_tag.present?
          price = product_doc.xpath('//li[contains(@class, "now_price")]/span').text.strip
          msrp = was_price_tag.text.strip
        else
          price = product_doc.xpath('//li[@class="product_price"]/span').text.strip
          msrp = price
        end
        price = price.gsub(',', '.')
        msrp = msrp.gsub(',', '.')
        more_info = product_doc.xpath('//div[@id="product_tab_1"]//ul[@class="product_summary"]').try(:children).try(:map, &:text)
        image_url = product_doc.xpath('//meta[@property="og:image"]/@content').text
        
        secondary_images = []

        color_infos = []          
        
        product_sku = product_doc.xpath('//li[@class="product_code"]/span').text
        item_import_key = "topshop_#{product_sku}"
        
        
        color_info = {}
        
        
        sizes_tags = product_doc.xpath('//ul[contains(@class, "product_size_grid")]/li/a')
        color_info[:sizes] = []
        color_info[:color_item_url] = prod_url
        if sizes_tags.present?
          sizes_tags.each do |size_tag|              
            color_info[:sizes] << size_tag['data-size']
          end
        else
          color_info[:sizes] = ['One Size']
        end

        image_urls = product_doc.xpath('//div[contains(@class, "product_thumb_carousel")]//ul/li/a/@href').map(&:text)
        
        color_info[:color] = product_doc.xpath('//li[@class="product_colour"]/span').try(:text).strip
        
        color_id = color_info[:color].split(' ').join('_').downcase
        color_info[:import_key] = "#{item_import_key}_#{color_id}"

        color_info[:images] = []          
        image_urls.each do |image_url|
          color_info[:images] <<  image_url.gsub("_small.jpg", "_large.jpg")
        end
        if image_urls.present?
          color_info[:image_url] = image_urls[0]
        else
          color_info[:image_url] = image_url
          color_info[:images] = [image_url]
        end


        color_infos << color_info          
      
      
        close_browser(b)
        all_sizes = []
        color_infos.each do |color_info|
          all_sizes = all_sizes | color_info[:sizes]
        end
      
        return {items: [{ 
          name: name, 
          description: desc, 
          url: prod_url,
          price: price,
          msrp: msrp,
          image_url: image_url,
          secondary_images: secondary_images,
          size: all_sizes, 
          more_info: more_info,
          import_key: item_import_key,
          colors: color_infos
        }]}
      rescue Exception => e
        puts '^' * 40
        puts "ERROR: Failed to fully scrape item with url: #{prod_url}"
        puts "Error: #{e}"
        puts '^' * 40
      end
      return {}
    end

  end
end