class Article < ApplicationRecord

	belongs_to :user
	has_many :favorites
	has_many :post_comments
	attachment :image

	#投稿がファボしてあるかどうかを判定する
	def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
    end

    def self.search(search)
      if search
        Article.where(['content LIKE ?', "%#{search}%"])
      else
        Article.all
      end
    end
end
