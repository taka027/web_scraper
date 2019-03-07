class Scrape
  include ActiveModel::Model

  attr_accessor :url, :email, :target_item, :target_tag
  # validations
  validates :url, presence: true, format: /\A#{URI::regexp(%w(http https))}\z/
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :target_item, presence: true
  validates :target_tag, presence: true
  
end
  