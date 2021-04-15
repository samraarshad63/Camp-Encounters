class AdminController < ApplicationController
  before_action :authenticate_admin!

  def index
    @pagy, @users = pagy(User.all, items: User::PER_PAGE)
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

  def search_users
    if @users = User.all.find{|user| user.firstname.include?(params[:search])}
      redirect_to view_user_admin_path(@users)
    end
  end
end
