require 'nokogiri'
require 'open-uri'
require 'watir-webdriver'
require 'watir-nokogiri'
require 'phantomjs'
require 'pry'


def parse_profiles(cat_doc)
  
  cat_doc.xpath('//a[contains(@class, "clickstream-link")][contains(@class, "link-wrapper")]/@href').map(&:value)
end

def get_total_page(cat_doc)  
  cat_doc.xpath('//ol[contains(@class, "pagination")]/li[position()=last()]/span/a/@data-galabel').text.to_i
end

def get_persons
  [
    { 
      f_name: "SERGIO",
      l_name: "CRUZ",
      address: "1000 Nw 71st Ave , Hollywood, FL 33024, United States"
    }
  ]
end

def main(auto = false)

  profiles_url = "http://www.whitepages.com/name/%%FIRST%%-%%LAST%%"
  domain = "http://www.whitepages.com/"

  f_name = "SERGIO"
  l_name = "CRUZ"

  cat_url = profiles_url.gsub("%%FIRST%%", f_name).gsub("%%LAST%%", l_name)

  puts "cat_url: #{cat_url}"

  cat_url = domain

  b = Watir::Browser.new(:firefox)

  b.goto cat_url
  b.execute_script("$('input[name=\"who\"]').attr('value', 'Sergio Cruz');")  
  b.button(class: 'submit').click

  # cat_doc = Nokogiri::HTML(open(cat_url))
  cat_doc = Nokogiri::HTML(b.html)

  total_page = get_total_page(cat_doc)
  profiles = parse_profiles(cat_doc)
  # File.open('/root/Temp/whitepages1.html', 'w+') do |f|
  #   f.write(cat_doc)
  # end
  # puts "total_page : #{total_page}"  
  # (2..total_page).each do |cur_page|
  #   cat_page_url = profiles_url.gsub("%%FIRST%%", f_name).gsub("%%LAST%%", l_name) + "/#{cur_page}"
  #   puts "cat_page_url: #{cat_page_url}"
  #   cat_page_doc = Nokogiri::HTML(open(cat_page_url))
  #   profiles << parse_profiles(cat_page_doc)
  # end

  profiles.flatten!
  puts "Count: #{profiles.count}"
  puts "First: #{profiles[0]}"
  puts "Last: #{profiles[-1]}"
  # b.close unless b.nil?
end

main