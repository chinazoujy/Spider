require "rubygems"
require "nokogiri"
require "open-uri"
# crawl only page of "http"
class Crawl
    def initialize(url, level)
      begin
        @doc = Nokogiri::HTML(open(url))
        @level = level
      rescue => exp
        puts exp
      end
    end
  
    def allLink
      links = getLinks(@doc)      
      @hash = Hash.new
      links.each do |link|
        @hash[link['href']] = 2
      end
      links.each{ |link| dfsLink(link['href'],0) }
      @hash.each {|key, value| puts "#{key} is #{value}" }
    end
    
    def getLinks(content)
      doc = content.css('a')
      return doc
    end
   
    # dfs scan
    # number 0 : page is disable
    # number 1 : page is able
    # number 2 : page is able or disable
    def dfsLink(url, count)
      begin
        if count == @level
          return 
        end
        doc   = Nokogiri::HTML(open(url))
        links = getLinks(doc)
        
        puts "Current scan url is :#{url}  value is #{@hash[url]}"
        @hash[url] = 1
        if links.size == 0  
          return
        else
          links.each do |link|
            href = link['href']
            if @hash.has_key?(href)
              @hash[href] = 1
            else
              @hash[href] = 2 
              dfsLink(href, count+1)
            end
          end
        end
      rescue => exp
        @hash[url] = 0
        return 
      end
    end
    
    # Test page can use or disable
    def use(url)
      begin
        Nokogiri::HTML(open(url))
        return true
      rescue => exp
        return false
      end
    end
end
  
  #$stdout.reopen("out.txt", "w")

  url = "http://www.baidu.com"
  url2 = "http://demo.aisec.cn/demo/aisec/"

  # scan count of level
  level = 2
  crawl = Crawl.new(url2, level)
  crawl.allLink










