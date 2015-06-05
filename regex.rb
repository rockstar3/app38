def scrap_link_from_styles(style)
	image_url = style.match(/background: url\((.*?)\)/)[1]
end