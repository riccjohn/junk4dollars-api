class UsersController < ApplicationController
  def index
    users = User.all_user_public_data
    render json: users
  end

  def show
    user = User.single_user_public_data(params[:id])
    render json: user
  end
end
