require 'rubygems'
require 'bundler/setup'
Bundler.require

files = Dir['md/*.md']
files.each do |fname|
  n = fname.split('/').last.gsub('.md', '')
  puts n.underscore
  words = []
  n.underscore.split('_').each do |w|
    puts "    #{w}"
    r = []
    %w(with and in).each do |t|
      if w.end_with?(t)
        r << w[0..(w.size - t.size - 1)]
        r << t
      end
    end
    r << w if r.empty?
    words << r
  end
  nfname = "md/#{words.flatten.join('_')}.md"
  `mv #{fname} #{nfname}`
end
