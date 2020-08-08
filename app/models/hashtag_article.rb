class HashtagArticle < ApplicationRecord
  belongs_to :article
  belongs_to :hashtag
  validates :article_id, presence: true
  validates :hashtag_id, presence: true
end
