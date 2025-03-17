# frozen_string_literal: true

module ChatManagement
  class ChatListPresenter < ApplicationPresenter

    def initialize(chats)
      @chats = chats
    end

    def serialize
      @chats.map { build_json(_1) }
    end

    private

    def build_json(chat)
      {
        id: chat.id,
        label: chat.label,
        chat_type: chat.chat_type,
        created_at: chat.created_at,
        updated_at: chat.updated_at,
        unread_count: chat.unread_count
      }
    end
  end
end