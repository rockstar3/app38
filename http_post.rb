require 'uri'
require 'net/http'
require 'net/https'

@toSend = {
    "date" => "2012-07-02",
    "aaaa" => "bbbbb",
    "cccc" => "dddd"
}.to_json

uri = URI.parse("http://us.topshop.com/webapp/wcs/stores/servlet/CatalogNavigationSearchResultCmd?


	Nrpp=20&No=20&pageNum=2&beginIndex=1&endIndex=11&pageFlag=s_20&N=14313+17446&catId=208634&parent_categoryId=208580")
https = Net::HTTP.new(uri.host,uri.port)
https.use_ssl = true
# req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json', 'User-Agent' => 'ruby'})
# req['foo'] = 'bar'
# req.body = "[ #{@toSend} ]"
# res = https.request(req)
# puts "Response #{res.code} #{res.message}: #{res.body}"




uri = URI.parse("http://us.topshop.com/webapp/wcs/stores/servlet/CatalogNavigationSearchResultCmd")
https = Net::HTTP.new(uri.host,uri.port)
# https.use_ssl = true
req = Net::HTTP::Post.new(
	uri.path, 	
	{'User-Agent'=>"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1)"}
	)
# params = {'beginIndex' => '1', 'catalogId' => '33060', 'dimSelected'=> '?Nrpp=20&No=20&pageNum=2&beginIndex=1&endIndex=11&pageFlag=s_20&N=14313+17446&catId=208634&parent_categoryId=208580', 'endIndex' => '11', 'isHash' => false, 'langId' => -1, 'pageFlag' => 's_20', 'pageNum' => 2, 'storeId' => 13052}
req['beginIndex'] = '1'
req['catalogId'] = '33060'
req['dimSelected'] = '?Nrpp=20&No=20&pageNum=2&beginIndex=1&endIndex=11&pageFlag=s_20&N=14313+17446&catId=208634&parent_categoryId=208580'
req['endIndex'] = '11'
req['isHash'] = false
# req['langId'] = '-1'
# req['pageFlag'] = 's_20'
# req['pageNum'] = '2'
# req['storeId'] = '13052'

res = https.request(req)
puts "Body:", res.body
