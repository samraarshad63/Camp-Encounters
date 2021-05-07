class UsersController < ApplicationController
  require 'date'

  before_action :authenticate_user!
  before_action :set_user, except: [:index, :dashboard]
  before_action :set_user_camp, only: [:dashboard, :select_camp]

  def index; end

  def show; end

  def edit; end

  def camp_intro; end

  def show_camps
    @camps = Camp.active
  end

  def select_camp
    return redirect_to camp_intro_user_path, notice: "You have already selected camp" if @application.present?

    @camp_user = CampUser.new(camp_users_params)
    @camp_user.user_id = current_user.id
    if @camp_user.save
      flash[:notice] = 'Camp Selected'
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
    end
    redirect_to camp_intro_user_path
  end

  def check_camp_date
    return redirect_to camp_intro_user_path, notice: 'Please participate in the next camp' if @user.camp.invalid_camp?

    redirect_to dashboard_user_path, notice: 'You can now start working on your application.'
  end

  def dashboard
    @registration_steps = session[:registration_steps]
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_user_camp
    @user = current_user
    @application = CampUser.find_by(user_id: @user.id)
  end

  private
  
  def camp_users_params
    params.permit(:camp_id)
  end
end
