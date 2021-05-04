class CampApplicationsController < ApplicationController
  include Wicked::Wizard
  include Registrable

  before_action :find_application_for_user, except: :index
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
  
  def find_application_for_user
    @user = current_user
    @camp_application = CampUser.find_by(user_id: @user.id)
    session[:registration_steps] = wizard_steps
  end

  private

  def user_params
    params.require(:camp_user).require(:user).permit(:firstname, :lastname, :email, :country, :contact)
  end

  def set_progress_bar
    unless params[:id] == "wicked_finish"
      step_index = wizard_steps.each_with_index.select { |i, idx| i =~ /#{step}/}
      step_index_results = step_index.map! { |i| i[1] }
      @current_step_position = step_index_results.first + 1 
      @total_step_count = wizard_steps.size
      if wizard_steps.any? && wizard_steps.index(step).present?
        @progress = ((wizard_steps.index(step) + 1).to_d / wizard_steps.count.to_d) * 100
      else
        @progress = 0
      end
    end
  end

  def check_application_status
    render 'registration_complete', alert: "You have submitted the application." if @camp_application.submitted
  end
end
