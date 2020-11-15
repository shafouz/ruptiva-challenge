class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize current_user
    @users = User.all
    render json: { users: @users }, status: 200
  end

  def show
    @user = User.find_by_uid(params[:uid])
    render json: { user: @user }, status: 200
  end
end
