class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { in: 2..20 }
  validates :email, presence: true
  validates :introduction, length: { maximum: 50 }

  attachment :profile_image

  has_many :articles, dependent: :destroy

  has_many :favorites, dependent: :destroy
  # ユーザーがファボした投稿を直接アソシエーションで取得する
  has_many :favorite_articles, through: :favorites, source: :article

  has_many :post_comments, dependent: :destroy

  has_many :events

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  # 自分がフォローしているユーザーとの関連
  # フォローする側のUserから見て、フォローされる側のUserを集める。なので親はfollowing_id(フォローする側)
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  # 中間テーブルを介して「follower」モデルのUser(フォローされた側)を集めることを「followings」と定義
  has_many :followings, through: :active_relationships, source: :follower

  # 自分がフォローされるユーザーとの関連
  # フォローされる側のUserから見て、フォローしてくる側のUserを集める。なので親はfollower_id(フォローされる側)
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  # 中間テーブルを介して「following」モデルのUser(フォローする側)を集めることを「followers」と定義
  has_many :followers, through: :passive_relationships, source: :following

  # Userがフォロー済みかどうか
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end
end
