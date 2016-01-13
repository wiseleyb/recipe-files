require 'rubygems'
require 'bundler/setup'
Bundler.require

`rm ../recipe-files/md/*.md`
`rm readme.md`

files = Dir['../recipe-files/original-html/*.html']
missing = []
readme = ['# Some old recipes I had lying around']
files.each do |fname|
  f = File.read(fname)
  f.scrub!("")
  f.encode!("UTF-8", "binary", invalid: :replace, undef: :replace, replace: "")

  page = Nokogiri::HTML(f)

  page.css('.editsection').remove
  page.css('#toc').remove
  page.css('#siteSub').remove
  page.css('.printfooter').remove
  page.css('#catlinks').remove
  page.xpath('//comment()').remove

  content = page.at_css('#content')
  h1 = content.at_css('h1')
  h1.content = h1.content.gsub("\r\n", "")

  content.search('p').each do |p|
    p.remove if p.css('a').size > 8
  end

  outname = fname.split('/').last.gsub('.html', '.md')

  readme << "* [#{h1.inner_text.strip}](md/#{outname})"
  outname = "../recipe-files/md/#{outname}"
  puts outname

  File.write(outname, ReverseMarkdown.convert(content.inner_html))
end

File.write('../recipe-files/readme.md', readme.join("\n"))
