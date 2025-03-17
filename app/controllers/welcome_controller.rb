class WelcomeController < ApplicationController

  def index
    render json: { api_status: 'online' }, status: :ok
  end
end
