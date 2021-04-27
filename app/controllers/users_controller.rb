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
    return redirect_to personal_info_user_path, notice: "You have already selected camp" if CampUser.find_by(user_id: params[:id]).present?

    @camp_user = CampUser.new(camp_users_params)
    @camp_user.user_id = current_user.id
    if @camp_user.save
      flash[:notice] = 'Camp Selected'
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
    end
    redirect_to personal_info_user_path
  end

  def find_user
    @user = User.find(params[:id])
  end

  private
  
  def camp_users_params
    params.permit(:camp_id)
  end
end
