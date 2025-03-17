# frozen_string_literal: true

module MessageManagement
  class MessageListQuery < ApplicationQuery

    def initialize(scope: nil, filters: nil, user_id:, chat_id:)
      @scope = scope || Message.all
      @filters = filters
      @user_id = user_id
      @chat_id = chat_id
    end

    def query
      @user = fetch_user
      @chat = fetch_chat
      return empty_response if @user.blank? || @chat.blank?

      @scope.select('messages.*')
            .joins('INNER JOIN chats ON chats.id = messages.chat_id')
            .joins('INNER JOIN chat_users ON chats.id = chat_users.chat_id')
            .where("chat_users.user_id = '#{@user.id}'")
            .where("chat_users.chat_id = '#{@chat.id}'")
    end

    private

    def fetch_user
      User.find_by(id: @user_id)
    end

    def fetch_chat
      Chat.find_by(id: @chat_id)
    end

    def empty_response
      Message.none
    end
  end
end