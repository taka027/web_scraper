class PageController < ApplicationController
  # トップページ
  def index
    @scrape = Scrape.new
  end
  
  # スクレイピング実行
  def run
    @scrape = Scrape.new(scrape_params)
    @url = params[:scrape][:url]
    @email = params[:scrape][:email]
    @target_item = params[:scrape][:target_item]
    @target_tag = params[:scrape][:target_tag]
    logger.debug("email:" + @email)
    if @scrape.valid?
      render :action => 'run'
      ScraperJob.perform_later(@email, @url, @target_item, @target_tag)
      
    else
      render :action => 'index'
    end
  end
  
  private
  
  def scrape_params
    params.require(:scrape).permit(:url, :email, :target_item, :target_tag)
  end
end
