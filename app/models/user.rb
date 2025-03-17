class User < ApplicationRecord
  has_many :chat_users
  has_many :chats, through: :chat_users
  has_many :messages, foreign_key: :sender_user_id
  has_many :message_tracks, foreign_key: :recipient_user_id

  scope :others_within_chat, ->(user, chat) do
    joins(:chat_users).where(chat_users: { chat: chat }).where.not(id: user.id)
  end
end
