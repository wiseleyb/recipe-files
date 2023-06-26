require 'rubygems'
require 'bundler/setup'
Bundler.require

puts "Recipe name?"
n = gets.chomp
title = n.titleize
fname = "md/#{n.downcase.gsub(' ', '_')}.md"

puts "Create recipe #{title} as #{fname}? (y/n)"
yn = gets.chomp

if yn.downcase == 'y'
 `cp md/new_recipe.md #{fname}`

  str = File.read(fname).gsub('# New Recipe', "# #{title}")
  File.write(fname, str)

 `ruby scripts/rebuild_readme.rb`
 system('vim', fname)
end
