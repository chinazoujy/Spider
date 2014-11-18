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
      @links = @doc.search("//@href")      
      @hash = Hash.new
      @links.each do |link|
         @hash[link] = 2 if link.to_s.include? "http" 
      end
      # main method
      otherLink
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
          links = doc.search("//@href")
          puts "Current scan url is :#{url}  value is #{@hash[url]}"
          @hash[url] = 1
          
          if links.size == 0  
            return
          else
            links.each do |link|
              if @hash.has_key?(link)
                @hash[link] = 1
              else
                @hash[link] = 2  if link.to_s.include? "http" 
                dfsLink(link, count+1) if link.to_s.include? "http"       
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
    
    def otherLink
      @links.each{ |link| dfsLink(link,0) if link.to_s.include? "http" }
      @hash.each {|key, value| puts "#{key} is #{value}" }
    end   

end

#$stdout.reopen("out.txt", "w")

url = "http://www.baidu.com"

# scan count of level
level = 0
crawl = Crawl.new(url, level)
crawl.allLink










