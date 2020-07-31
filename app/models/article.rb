class Article < ApplicationRecord

	belongs_to :user
	has_many :favorites
	has_many :post_comments
	attachment :image

	#投稿がファボしてあるかどうか」を判定する
	def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
    end
end
