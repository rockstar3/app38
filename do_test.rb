[[{:name=>"Tribeca Lace Dress", :description=>"Fearless bodycon dress rocking a placed-lace design and wide double scoopnecks. Snug, uncomplicated fit. No closures. Partially lined.", :url=>"http://www.bebe.com/Clothing/Dresses/All-Dresses/Tribeca-Lace-Dress/pc/636/c/197/sc/198/93378.pro", :price=>"$79.00", :msrp=>"$79.00", :image_url=>"http://s7d9.scene7.com/is/image/bebe/rbb-252251-iwe-i1?wid=600&hei=600", :secondary_images=>[], :size=>["P/S", "M/L"], :more_info=>[], :import_key=>"bebe_93378", :colors=>[{:sizes=>["P/S", "M/L"], :color_item_url=>"http://www.bebe.com/Clothing/Dresses/All-Dresses/Tribeca-Lace-Dress/pc/636/c/197/sc/198/93378.pro", :image_url=>"http://s7d9.scene7.com/is/image/bebe/rbb-252251-iwe-swatch?$SwatchBig$", :color=>"BRIGHT WHITE", :import_key=>"bebe_93378_rbb-252251-iwe",

 :images=>["http://s7d9.scene7.com/is/image/bebe/rbb-252251-iwe-i4", 
 "http://s7d9.scene7.com/is/image/bebe/rbb-252251-iwe-i4", "http://s7d9.scene7.com/is/image/bebe/rbb-252251-iwe-i4", "http://s7d9.scene7.com/is/image/bebe/rbb-252251-iwe-i4"]}, 


 {:sizes=>["P/S", "M/L"], :color_item_url=>"http://www.bebe.com/Clothing/Dresses/All-Dresses/Tribeca-Lace-Dress/pc/636/c/197/sc/198/93378.pro", :image_url=>"http://s7d9.scene7.com/is/image/bebe/rbb-252251-ric-swatch?$SwatchBig$", :color=>"CERAMIC", :import_key=>"bebe_93378_rbb-252251-ric", :images=>["http://s7d9.scene7.com/is/image/bebe/rbb-252251-ric-i4", "http://s7d9.scene7.com/is/image/bebe/rbb-252251-ric-i4", "http://s7d9.scene7.com/is/image/bebe/rbb-252251-ric-i4", "http://s7d9.scene7.com/is/image/bebe/rbb-252251-ric-i4"]}, {:sizes=>["P/S", "M/L"], :color_item_url=>"http://www.bebe.com/Clothing/Dresses/All-Dresses/Tribeca-Lace-Dress/pc/636/c/197/sc/198/93378.pro", :image_url=>"http://s7d9.scene7.com/is/image/bebe/rbb-252251-eab-swatch?$SwatchBig$", :color=>"PEACOCK BLUE", :import_key=>"bebe_93378_rbb-252251-eab", :images=>["http://s7d9.scene7.com/is/image/bebe/rbb-252251-eab-i4", "http://s7d9.scene7.com/is/image/bebe/rbb-252251-eab-i4", "http://s7d9.scene7.com/is/image/bebe/rbb-252251-eab-i4", "http://s7d9.scene7.com/is/image/bebe/rbb-252251-eab-i4"]}]}]]


image_urls = []
default_image = "Test1"
(1..4).each do |idx|
	default_image[-1] = idx.to_s                
	image_urls << "#{default_image}"
	puts image_urls
end