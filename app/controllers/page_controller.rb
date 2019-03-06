class PageController < ApplicationController
  # トップページ
  def index
    @scrape = Scrape.new
  end
  
  # スクレイピング実行
  def run
    @scrape = Scrape.new(scrape_params)
    @message = params[:scrape][:url]
    if @scrape.valid?
      render :action => 'run'
    else
      render :action => 'index'
    end
  end
  
  private
  
  def scrape_params
    params.require(:scrape).permit(:url)
  end
end
