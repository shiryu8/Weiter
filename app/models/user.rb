class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles, dependent: :destroy
  has_many :favorites, dependent: :destroy
  #ユーザーがファボした投稿を直接アソシエーションで取得する
  has_many :favorite_articles, through: :favorites, source: :article
  has_many :post_comments, dependent: :destroy
  attachment :profile_image
end
