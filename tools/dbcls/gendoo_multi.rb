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


input_file, column, dsn, out_file = ARGV
input = File.open(input_file).read.split("\n").map {|x| x.split("\t")[column.to_i - 1].strip }

# http://gendoo.dbcls.jp/pre/cgi-bin/gendoo.cgi?geneid=slr1311%0D%0Aslr1312&genename=&taxonomy=synecho&submit=Search
queries = input.join("%0D%0A")
url = "http://gendoo.dbcls.jp/pre/cgi-bin/gendoo.cgi?geneid=#{queries}&genename=&taxonomy=#{dsn}&submit=Search"

text = open(url).read
i = 0
File.open(out_file, 'w') do |f|                     
  aspect = ''
  meshid = ''
  term = ''
  text.split("\n").each do |line|
    case line
    when Matcher.ig_and_pvalue
      ig = $1
      pvalue = $2
      query = input[i]
      i += 1
      i = 0 if i == input.size
      f.puts [dsn, query, meshid, aspect, term, ig, pvalue].join("\t")
    when Matcher.meshid_and_term(dsn)
      meshid = $1
      term = $2
    when Matcher.aspect
      aspect = $1
    end
  end
end
puts "Gendoo: #{input.join(",")} related diseases, drugs, ..."
