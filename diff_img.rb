require 'rmagick'
img1 =  Magick::Image.read('http://s7d9.scene7.com/is/image/bebe/noimage')
img2 =  Magick::Image.read('http://s7d9.scene7.com/is/image/bebe/noimage2')

MiniMagick::Image.open("http://s7d9.scene7.com/is/image/bebe/noimage")

MiniMagick::Image.open("http://s7d9.scene7.com/is/image/bebe/rbb-254058-rsg-i2")
diff_img, diff_metric  = img1[0].compare_channel( img2[0], Magick::MeanSquaredErrorMetric )


img1 = Curl.get("http://s7d9.scene7.com/is/image/bebe/noimage")
img2 = Curl.get("http://s7d9.scene7.com/is/image/bebe/noimage2")
img3 = Curl.get("http://s7d9.scene7.com/is/image/bebe/rbb-254058-rsg-i2")


Digest::MD5.file "logo1.png"
Digest::MD5.file "http://s7d9.scene7.com/is/image/bebe/noimage"

file_contents1 = open('http://s7d9.scene7.com/is/image/bebe/noimage') { |f| f.read }
md5_1 = Digest::MD5.hexdigest(file_contents)

file_contents2 = open('http://s7d9.scene7.com/is/image/bebe/noimage2') { |f| f.read }
md5_2 = Digest::MD5.hexdigest(file_contents2)


file_contents3 = open('http://s7d9.scene7.com/is/image/bebe/rbb-254058-rsg-i2') { |f| f.read }
md5_3 = Digest::MD5.hexdigest(file_contents3)

md5_1 == md5_2
md5_1 == md5_3

md5_1 = Digest::MD5.hexdigest(open('http://s7d9.scene7.com/is/image/bebe/noimage') { |f| f.read })

md5_2 = Digest::MD5.hexdigest(open('http://s7d9.scene7.com/is/image/bebe/noimage2') { |f| f.read })

md5_3 = Digest::MD5.hexdigest(open('http://s7d9.scene7.com/is/image/bebe/rbb-254058-rsg-i2') { |f| f.read })
