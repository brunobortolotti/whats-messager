class MessagesController < ApplicationController
  before_action :set_message, only: :message_tracks

  def index
    message_query = MessageManagement::MessageListQuery.call \
      user_id: query_params[:user_id],
      chat_id: query_params[:chat_id]

    render json: message_query
  end

  def create
    result = MessageManagement::CreateMessage.call \
      user_id: params[:user_id],
      params: create_params

    if result.success?
      render json: { message: result.message }
    else
      render json: { error: 'Error creating the message' }, status: :unprocessable_entity
    end
  end

  def message_tracks
    if @message.present?
      render json: @message.message_tracks
    else
      render json: { error: 'Message not found' }, status: :not_found
    end
  end

  private

  def query_params
    params.permit(:user_id, :chat_id)
  end

  def set_message
    @message = Message.find_by(id: params[:id])
  end

  def create_params
    params.require(:message).permit(:chat_id, :content)
  end
end
