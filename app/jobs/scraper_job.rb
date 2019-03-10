require 'open-uri'
#require 'selenium-webdriver'
class ScraperJob < ApplicationJob
  queue_as :scraper

  def perform(email, url, target_item, target_tag)
    result = ""
    begin
      
      # スクレイピング開始
      charset = nil
      
      html = open(url, {:redirect => true, 'User-Agent' => 'robo/0.1'}) do |f|
        charset = f.charset
        f.read
      end
  
      # logger.debug("charset:" + charset)
      # options = Selenium::WebDriver::Chrome::Options.new
      # options.add_argument('--headless')

      # driver = Selenium::WebDriver.for :chrome, options: options
      # #driver.manage.timeouts.implicit_wait = 10 
      # driver.get url
      # doc = Nokogiri::HTML driver.page_source.encode("UTF-8") 
      doc = Nokogiri::HTML.parse(html, nil, charset)
  
      #logger.debug("doc:" + doc.to_s)
      
      doc.xpath(target_item).each do |n|
        #取得
        te = n.css(target_tag).inner_text
        #logger.debug("inner_text :node[" + n.to_s + "]:" + te)
        result << te + "\n"
      end
      
      UserMailer.notice(email, url, result).deliver_now
    rescue => e
      logger.error(e)
    end
    
    
    
  end
end
