# microbe_base.rb DS DSN symbol output
# microbe_base.rb DS DSN output

require 'open-uri'

class MicrobeBase
  attr :dsn
  def initialize(ds, dsn = nil)
    @ds = ds
    @dsn = dsn
  end

  def fetch_gene_list
    url = base_url(@dsn) + "/genes.txt"
    open(url).read
  end
  
  def fetch_gene(gene_name)
    url = base_url(@dsn) + "/genes/#{gene_name}"
    open(url).read
  end
  
  def base_url(dsn = nil)
    url = "http://genome.kazusa.or.jp/#{@ds}"
    url + "/#{dsn}" if dsn
  end
end


case ARGV.size
when 3
  ds,dsn,output = ARGV
  cb = MicrobeBase.new(ds, dsn)
  File.open(output, 'w') do |f|
    f.puts cb.fetch_gene_list
  end
when 4
  ds,dsn,gene,output = ARGV
  cb = MicrobeBase.new(ds, dsn)
  File.open(output, 'w') do |f|
    f.puts cb.fetch_gene(gene)
  end
else
end
puts "CyanoBase Gene List."

