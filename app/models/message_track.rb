class MessageTrack < ApplicationRecord
  belongs_to :chat
  belongs_to :recipient_user, class_name: 'User', foreign_key: :recipient_user_id
  belongs_to :message

  delegate :sender_user, to: :message
end
