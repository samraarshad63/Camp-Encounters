class CampApplicationsController < ApplicationController
  include Wicked::Wizard

  before_action :find_application_for_user, except: :index

  steps :personal_info, :emergency_contact_info, :camp_activities, :condition_of_health, :need_for_first_aid, :avail_food_Service, :avail_internet_service, :provide_social_media_info, :provide_side_note, :confirm_camp_registration

  def show
    render_wizard
  end

  def update
    case step
    when :personal_info
      @camp_application.update_attribute(:gender, params[:gender])
    when :emergency_contact_info
      @camp_application.update(contact_info_params)
    when :condition_of_health
      @camp_application.update_attribute(:health_condition, params.dig(:camp_user, :health_condition))
    when :need_for_first_aid
      @camp_application.update_attribute(:require_first_aid, params[:require_first_aid])
    when :avail_food_Service
      @camp_application.update_attribute(:avail_food_service, params[:avail_food_service])
    when :avail_internet_service
      @camp_application.update_attribute(:avail_internet_service, params[:avail_internet_service])
    when :provide_social_media_info
      @camp_application.update_attribute(:social_media_handle, params.dig(:camp_user, :social_media_handle))
    when :provide_side_note
      @camp_application.update_attribute(:side_note, params.dig(:camp_user, :side_note))
    end
    render_wizard @camp_application
  end
  
  def find_application_for_user
    @user = current_user
    @camp_application = CampUser.find_by(user_id: @user.id)
  end

  private

  def contact_info_params
    params.require(:camp_user).permit(:mailing_address, :emergency_contact)
  end

  def camp_activities_params
    params.require(:camp_user).permit(:camp_activity, :contribution)
  end
end
