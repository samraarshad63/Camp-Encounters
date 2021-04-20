class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, except: [:index]

  def index; end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def find_user
    @user = User.find(params[:id])
  end
end
