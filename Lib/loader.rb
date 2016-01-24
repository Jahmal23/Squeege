
require 'nokogiri'
require 'open-uri'

#This class is responsible for any whitepages http requests and passing back any downloaded content

class Loader

    @@BASE_WHITE_PAGES_URL = "http://www.whitepages.com/"

    def get_content

      page = Nokogiri::HTML(open(@@BASE_WHITE_PAGES_URL))

      #'<html><body>junk</body></html>'

      page.css('body.home-page').each do |node|
        puts node.text
      end
    end

end