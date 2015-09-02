require 'open-uri'
require 'nokogiri'
# page_doc = Nokogiri::HTML(open('http://us.topshop.com/webapp/wcs/stores/servlet/CatalogNavigationSearchResultCmd?Nrpp=20&No=20&pageNum=2&beginIndex=1&endIndex=11&pageFlag=s_20&N=14313+17446&catId=208634&parent_categoryId=208580', 'User-Agent'=>'ruby'))

page_doc = Nokogiri::HTML(open('http://us.topshop.com/en/tsus/category/clothing-70483/dresses-70497?#catalogId=33060&viewAllFlag=false&sort_field=Relevance&langId=-1&storeId=13052&categoryId=208634&Nrpp=20&No=20&pageNum=2&beginIndex=1&endIndex=11&pageFlag=s_20&N=14313+17446&catId=208634&parent_categoryId=208580', 'User-Agent'=>'ruby'))

File.open('/root/Temp/Topshop/page_doc.html', 'w+') do |f|
	f.write(page_doc)
end