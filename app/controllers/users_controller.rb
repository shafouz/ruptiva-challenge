class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize current_user
    @users = User.all
    render json: { users: @users }, status: 200
  end

  def show
    @user = current_user
    render json: { user: @user }, status: 200
  end

  def admin_show
    authorize current_user
    @user = User.find_by_email(params[:email])
    render json: { user: @user }, status: 200
  end
end
