class Scrape
  # MixIn
  include ActiveModel::Model

  attr_accessor :url
  # validations
  validates :url, presence:  { message: 'URL は必須入力です。'}
  
end
  