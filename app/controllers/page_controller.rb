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
    @path = "/" + filename
    if @scrape.valid?
      render :action => 'run'
      ScraperJob.perform_later(filename, url, target_item, target_tag, get_charcode)
      
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

end
