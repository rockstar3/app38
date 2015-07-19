require 'open-uri'
require 'net/http'
# params = {'beginIndex' => '1', 'catalogId' => '33060', 'dimSelected'=> '?Nrpp=20&No=20&pageNum=2&beginIndex=1&endIndex=11&pageFlag=s_20&N=14313+17446&catId=208634&parent_categoryId=208580', 'endIndex' => '11', 'isHash' => false, 'langId' => -1, 'pageFlag' => 's_20', 'pageNum' => 2, 'storeId' => 13052}
# url = URI.parse('http://us.topshop.com/webapp/wcs/stores/servlet/CatalogNavigationSearchResultCmd')

uri = URI.parse('http://us.topshop.com/webapp/wcs/stores/servlet/CatalogNavigationSearchResultCmd?Nrpp=20&No=20&pageNum=2&beginIndex=1&endIndex=11&pageFlag=s_20&N=14313+17446&catId=208634&parent_categoryId=208580')

# resp, data = Net::HTTP.post_form(url, params)
# puts resp.inspect
# puts data.inspect

# req = Net::HTTP::Post.new("#{uri.path}?#{uri.query}", {
#     'Referer' => "http://www.example.com/referer",
#     'User-Agent'=> "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1)",
#     'Cookie' => $cookie
# })
http = Net::HTTP.new(uri.host, uri.port)
req = Net::HTTP::Post.new("#{uri.path}?#{uri.query}", 
	{'User-Agent'=> "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1)", 'Content-Type' =>'text/html; charset=UTF-8'})
	# {'User-Agent'=> "Ruby", 'Content-Type' =>'application/x-www-form-urlencoded'})
response = http.request(req)
puts response.inspect