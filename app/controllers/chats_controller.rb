class ChatsController < ApplicationController

  def index
    chats_query = ChatManagement::ChatListQuery.call(user_id: query_params[:user_id])
    chats_json = ChatManagement::ChatListPresenter.serialize(chats_query)
    render json: chats_json, status: :ok
  end

  private

  def query_params
    params.permit(:user_id)
  end
end
