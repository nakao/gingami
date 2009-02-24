require 'open-uri'

class Matcher
  def self.ig_and_pvalue
    /<td class="\S+" title="IG=(\d.*?), p-value=(\d.*?)">/
  end

  def self.meshid_and_term(dsn)
    /gendoo.cgi\?meshid=(D\d+)\&taxonomy=#{dsn}">(\w+.*?\w+)<\/a>/
  end
  
  def self.aspect
    /<h2><a name="\w+">(\w+.*?\w+)<\/a><\/h2>/
  end
end


query, dsn, output = ARGV
# http://gendoo.dbcls.jp/pre/cgi-bin/gendoo.cgi?geneid=slr1311&taxonomy=synecho
url = "http://gendoo.dbcls.jp/pre/cgi-bin/gendoo.cgi?geneid=#{query}&taxonomy=#{dsn}"
text = open(url).read
File.open(output, 'w') do |f|                     
  aspect = ''
  meshid = ''
  term = ''
  text.split("\n").each do |line|
    case line
    when Matcher.ig_and_pvalue
      ig = $1
      pvalue = $2
      f.puts [dsn, query, meshid, aspect, term, ig, pvalue].join("\t")
    when Matcher.meshid_and_term(dsn)
      meshid = $1
      term = $2
    when Matcher.aspect
      aspect = $1
    end
  end
end
puts "Gendoo: #{query} related diseases, drugs, ..."

