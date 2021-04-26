class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, except: [:index]

  def index; end

  def show; end

  def edit; end

  def personal_info; end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show_camps
    @camps = Camp.where(status: "active")
  end

  def select_camp
    if CampUser.find_by(user_id: params[:id])
      flash[:notice] = "You have already selected camp"
      redirect_to user_personal_info_path
    else
      @camp_user = CampUser.new(camp_users_params)
      @camp_user.user_id = params[:id]
      @camp_user.save
      flash[:notice] = "Camp Selected"
      redirect_to user_personal_path
    end
  end

  def find_user
    @user = User.find(params[:id])
  end

  private
  
  def camp_users_params
    params.permit(:camp_id)
  end
end
