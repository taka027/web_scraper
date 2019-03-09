require 'open-uri'
class ScraperJob < ApplicationJob
  queue_as :scraper

  def perform(email, url, target_item, target_tag)
    result = ""
    begin
      
      # スクレイピング開始
      charset = nil
      
      html = open(url) do |f|
        charset = f.charset
        f.read
      end
  
      doc = Nokogiri::HTML.parse(html, nil, charset)
  
      
      doc.xpath(target_item).each do |n|
        #取得
        result << n.css(target_tag).inner_text + "\n"
      end
      
      UserMailer.notice(email, url, result).deliver_now
    rescue => e
      logger.error(e.backtrace.join("\n"))
    end
    
    
    
  end
end
