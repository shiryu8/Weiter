 # encoding: utf-8

class Article < ApplicationRecord

	belongs_to :user

	has_many :favorites

	has_many :post_comments

  has_many :hashtag_articles, dependent: :destroy
  has_many :hashtags, through: :hashtag_articles

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

    #ハッシュタグを作成
    after_create do
      #作成したArticleを探す
      article = Article.find_by(id: id)
      # hashbodyに打ち込まれたハッシュタグを検出
      hashtags = article.hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
      #mapで繰り返すことにより、複数のハッシュタグがarticleに保存
      hashtags.uniq.map do |hashtag|
        # ハッシュタグは先頭の#を外した上で保存
        tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
        article.hashtags << tag
      end
    end

    #更新アクション
    before_update do
      article = Article.find_by(id: id)
      article.hashtags.clear
      hashtags = hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
      hashtags.uniq.map do |hashtag|
        tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
        article.hashtags << tag
      end
    end
end
