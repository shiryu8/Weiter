class Hashtag < ApplicationRecord
  validates :hashname, presence: true, length: { maximum: 50 }
  has_many :hashtag_articles, dependent: :destroy
  has_many :articles, through: :hashtag_articles
end
