class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles, dependent: :destroy
  has_many :favorites
  #ユーザーがファボした投稿を直接アソシエーションで取得する
  has_many :favorite_articles, through: :favorites, source: :article
  attachment :profile_image
end
