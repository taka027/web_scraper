class Scrape
  include ActiveModel::Model

  attr_accessor :url, :target_item, :target_tag
  # validations
  validates :url, presence: true, format: /\A#{URI::regexp(%w(http https))}\z/
  validates :target_item, presence: true
  validates :target_tag, presence: true
  
end
  