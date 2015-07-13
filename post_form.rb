require 'net/http'
require 'uri'
 
url = 'http://us.topshop.com/webapp/wcs/stores/servlet/CatalogNavigationSearchResultCmd'
uri = URI.parse(url)
 
params = {'beginIndex' => '1', 'catalogId' => '33060', 'dimSelected'=> '?Nrpp=20&No=20&pageNum=2&beginIndex=1&endIndex=11&pageFlag=s_20&N=14313+17446&catId=208634&parent_categoryId=208580', 'endIndex' => '11', 'isHash' => false, 'langId' => -1, 'pageFlag' => 's_20', 'pageNum' => 2, 'storeId' => 13052}
 

## Shortcut
# response  = Net::HTTP.post_form(uri, params)


## Full control
http = Net::HTTP.new(uri.host, uri.port)

request = Net::HTTP::Post.new(uri.request_uri, {'User-Agent' => 'Ruby'})
request.set_form_data(params)

response = http.request(request)


puts response.inspect