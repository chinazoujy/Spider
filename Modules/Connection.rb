 require "rubygems"
 require "open-uri"
 require "uri"                  # analysis url
 require "nokogiri"             # analysis html document

 class URLCheck
   def check (uri)
     unless uri.include? "://"
       uri = "http://"+uri
       return uri
     end
     return uri
   end
 end
 
 class Connection
   def initialize 
     @parrenURLAttr = Hash.new
     @parrenURLAttr[scheme] = ""
     @parrenURLAttr[host] = ""
     @parrenURLAttr[port] = ""
     @parrenURLAttr[path] = ""
   end
   
   def parseURI (uri)
     link = URI(uri)
     @parrenURLAttr = link.scheme
     @parrenURLAttr = link.host
     @parrenURLAttr = link.port
     @parrenURLAttr = link.path
   end

   
   
 end

=begin
   uri = "http://www.demo.com/demo/"
   uri2 = " http://music.baidu.com:8080/audio?id=123&lan=en#qasd123"
   conn = Connection.new
   conn.parseURI(uri2)
=end
   
