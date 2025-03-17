class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :sender_user, class_name: 'User', foreign_key: :sender_user_id
  has_many :message_tracks
end
