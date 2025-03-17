# frozen_string_literal: true

module MessageManagement
  class CreateMessage < ApplicationInteractor
    attr_reader :user, :chat, :message, :message_tracks

    def initialize(user_id:, params:)
      super

      @user_id = user_id
      @params = (params || {}).to_h.deep_symbolize_keys
    end

    def execute
      ActiveRecord::Base.transaction do
        fetch_user &&
          fetch_chat &&
          create_message &&
          create_tracks
      end
    end

    private

    def fetch_user
      @user = User.find_by(id: @user_id)
      return true if @user.present?

      add_error('User not found')
      Rails.logger.error \
        message: 'Error creating message',
        user_id: @user_id

      raise ActiveRecord::Rollback
    end

    def fetch_chat
      @chat = Chat.find_by(id: @params[:chat_id])
      return true if @chat.present?

      add_error('Chat not found')
      Rails.logger.error \
        message: 'Chat not found',
        user_id: @user.id,
        chat_id: @params[:chat_id]

      raise ActiveRecord::Rollback
    end

    def create_message
      @message = Message.new \
        chat: @chat,
        sender_user: @user,
        content: @params[:content]

      return true if @message.save

      add_error('Error creating message')
      Rails.logger.error \
        message: 'Error creating message',
        chat_id: @chat.id,
        user_id: @user.id,
        details: @message.errors.full_messages

      raise ActiveRecord::Rollback
    end

    def create_tracks
      @message_tracks = []

      User.others_within_chat(@user, @chat).each do |user|
        track = create_message_track

        if track.errors.blank?
          @message_tracks << track
        else
          add_error('Error creating track')
          Rails.logger.error \
              message: 'Error creating track',
              chat_id: @chat.id,
              user_id: @user.id,
              message_id: @message.id,
              details: track.errors.full_messages

          raise ActiveRecord::Rollback
        end
      end
    end

    def create_message_track
      MessageTrack.create \
        chat: @chat,
        message: @message,
        recipient_user: user,
        sent_at: DateTime.now,
        delivered_at: nil,
        read_at: nil
    end
  end
end