require 'nokogiri'
require 'open-uri'
require 'watir-webdriver'
require 'watir-nokogiri'
require 'phantomjs'
require 'pry'

def get_states(root_doc)
  rlt = []
  state_tags = root_doc.xpath('//div[@id="home1"]/ul[@class="tab-list tab-list-long"]/li/a')
  state_tags.each do |state_tag|
    data = {
      name: state_tag.text,
      url: state_tag['href']
    }    
    rlt << data unless state_tag.text.include?('Small towns')
  end
  rlt
end

def get_cities(state_detail_doc)
  city_tags = state_detail_doc.xpath('//table[@id="cityTAB"]//td/a')
  city_tags.map{|city_tag| {name: city_tag.text, url: city_tag['href']}}
end

def store_city
  my = Mysql.connect('hostname', 'user', 'password', 'dbname')
  res = my.query 'insert city(name) value'
  
end

def main(auto = false)

  city_data_url = "http://city-data.com/"
  city_urls = []
  b = Watir::Browser.new(:phantomjs)          
  b.goto city_data_url

  root_doc = Nokogiri::HTML(b.html)

  states = get_states(root_doc)
  # puts states.count
  # puts states

  states.each do |state|
    b.goto state[:url]
    b.select_list(:id => 'citySize').option(:value => "all").select
    state_detail_doc = Nokogiri::HTML(b.html)
    cities = get_cities(state_detail_doc)
    # puts cities[0]    
    # puts cities.count
    
    # puts "http://www.city-data.com/city/#{cities[0]['href']}"
    # b.goto "http://www.city-data.com/city/#{cities[0]['href']}"
    puts cities[0][:url]
    
    b.a(href: "#{cities[0][:url]}").click
    city_detail_doc = Nokogiri::HTML(b.html)
    b.screenshot.save '/root/Temp/city.png'
    zip_code = city_detail_doc.xpath('//section[@id="zip-codes"]').text
    puts "zip_code: #{zip_code}"

    break 
  end

  b.close unless b.nil?

end

main