# frozen_string_literal: true

module ChatManagement
  class ChatListQuery < ApplicationQuery

    def initialize(scope: nil, filters: nil, user_id:)
      @scope = scope || Chat.all
      @filters = filters
      @user_id = user_id
    end

    def query
      @user = fetch_user
      return empty_response if @user.blank?

      @scope.select(select_attributes)
            .joins(:chat_users)
            .where(chat_users: { user: @user })
    end

    private

    def fetch_user
      User.find_by(id: @user_id)
    end

    def select_attributes
      'chats.*, chat_users.unread_count'
    end

    def empty_response
      Chat.none
    end
  end
end