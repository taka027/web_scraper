require 'open-uri'
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
  
      doc = Nokogiri::HTML.parse(html, nil, charset)
  
      #logger.debug("doc:" + doc.to_s)
      
      doc.xpath(target_item).each do |n|
        #取得
        te = n.css(target_tag).inner_text
        logger.debug("inner_text :node[" + n.to_s + "]:" + te)
        result << te + "\n"
      end
      
      UserMailer.notice(email, url, result).deliver_now
    rescue => e
      logger.error(e)
    end
    
    
    
  end
end
