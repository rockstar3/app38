def scrap_link_from_styles(style)
	image_url = style.match(/background: url\((.*?)\)/)[1]
end
# def api_resource
# 	API_URL.gsub("%%products_per_page%%", "1000").gsub("%%folderId%%", folderId)
# end