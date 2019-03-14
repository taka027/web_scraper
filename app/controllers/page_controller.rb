class PageController < ApplicationController
  # トップページ
  def index
    @scrape = Scrape.new
  end
  
  # スクレイピング実行
  def run
    @scrape = Scrape.new(scrape_params)
    url = params[:scrape][:url]
    target_item = params[:scrape][:target_item]
    target_tag = params[:scrape][:target_tag]
    filename = SecureRandom.hex(16) + ".csv"
    
    if @scrape.valid?
      @path = scrape(filename, url, target_item, target_tag, get_charcode)
      render :action => 'run'
      
    else
      render :action => 'index'
    end
  end
  
  private
  
  def scrape_params
    params.require(:scrape).permit(:url, :target_item, :target_tag)
  end
  
  def get_charcode
    if request.headers["HTTP_USER_AGENT"].index("Windows")
      "Shift_JIS"
    else
      "UTF-8"
    end
  end

  def scrape(filename, url, target_item, target_tag, charcode)
    result = ""
    begin
      # スクレイピング開始
      charset = nil
      
      html = open(url, {:redirect => true, 'User-Agent' => 'robo/0.1'}) do |f|
        charset = f.charset
        f.read
      end
  
      doc = Nokogiri::HTML.parse(html, nil, charset)
  
      doc.xpath(target_item).each do |n|
        #取得
        target_tag.split(",").each do |s|
          te = ""
          if n.css(s)
            te = n.css(s).inner_text.gsub(/(\r\n|\r|\n)/, "").encode(charcode)
          end
          result << "\"" + te + "\","
        end

        #logger.debug("inner_text :node[" + n.to_s + "]:" + te)
        result << "\n"
      end
      
      output_path = Rails.root.join('public', filename)

      File.open(output_path, 'w+b') do |fp|
        fp.write result
      end
      
      "/" + filename
    rescue => e
      logger.error(e)
      e.message
    end
    
  end
end
