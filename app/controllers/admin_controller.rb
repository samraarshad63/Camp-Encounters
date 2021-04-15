class AdminController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
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
end
