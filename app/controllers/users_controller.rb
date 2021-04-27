class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, except: [:index]

  def index; end

  def show; end

  def edit; end

  def personal_info; end

  def show_camps
    @camps = Camp.active
  end

  def select_camp
    return redirect_to user_personal_info_path, notice: "You have already selected camp" if CampUser.find_by(user_id: params[:id]).present?

    @camp_user = CampUser.new(camp_users_params)
    @camp_user.user_id = params[:id]
    if @camp_user.save
      redirect_to user_personal_path, notice: 'Camp Selected'
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
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
