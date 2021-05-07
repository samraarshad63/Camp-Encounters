class CampApplicationsController < ApplicationController
  include Wicked::Wizard
  include Registrable

  before_action :set_user_application, except: :index
  before_action :set_progress_bar, only: [:show]
  before_action :check_application_status

  steps :personal_info, :emergency_contact_info, :camp_activities, :condition_of_health, :need_for_first_aid, :avail_food_Service, :avail_internet_service, :provide_social_media_info, :provide_side_note, :confirm_camp_registration

  def registration_complete; end

  def show
    render_wizard
  end

  def update
    return render 'registration_complete' if @camp_application.submitted

    render_wizard update_steps
  end
  
  def set_user_application
    @user = current_user
    @camp_application = CampUser.find_by(user_id: @user.id)
    session[:registration_steps] = wizard_steps
  end

  private

  def user_params
    params.require(:camp_user).require(:user).permit(:firstname, :lastname, :email, :country, :contact)
  end

  def set_progress_bar
    return if params[:id] == "wicked_finish"

    @current_step_position = step_index_result
    @total_step_count = wizard_steps.size
    @progress = progress
  end

  def check_application_status
    render 'registration_complete', alert: "You have submitted the application." if @camp_application.submitted
  end
end
