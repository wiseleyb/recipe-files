require 'rubygems'
require 'bundler/setup'
Bundler.require

readme = ['# Some old recipes I had lying around']
files = Dir['md/*.md'].sort
files.each do |fname|
  n = fname.split('/').last.gsub('.md', '').titleize
  readme << "* [#{n}](#{fname})"
end

File.write('../recipe-files/readme.md', readme.join("\n"))
