class Message < ApplicationRecord
  #メッセージが空白の場合、保存されない
  validates :talk_message, presence: true
  belongs_to :user
  belongs_to :room
end
