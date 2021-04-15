class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @pagy, @users = pagy(User.search(params[:search]), items: User::PER_PAGE)
  end

  def show
    @admin = Admin.find(params[:id])
  end

  def view_user
    @user = User.find(params[:id])
  end

  def edit_user
    @user = User.find(params[:id])
    render "users/edit"
  end

  private
  
  def user_params
    params.require(:user).permit(:search)
  end
end
