class CampApplicationsController < ApplicationController
  include Wicked::Wizard

  before_action :find_application_for_user, except: :index
  before_action :set_progress_bar, only: [:show]

  steps :personal_info, :emergency_contact_info, :camp_activities, :condition_of_health, :need_for_first_aid, :avail_food_Service, :avail_internet_service, :provide_social_media_info, :provide_side_note, :confirm_camp_registration

  def show
    render_wizard
  end

  def update
    case step
    when :personal_info
      @user.update(user_params)
      if params[:gender].present?
        update_progress() if @camp_application.gender.blank?
        @camp_application.update_attribute(:gender, params[:gender])
        if params.dig(:camp_user, :user_image)
          @camp_application.user_image.attach(params.dig(:camp_user, :user_image))
          @camp_application.user_image.purge if @camp_application.user_image.attached?
        end
      end

    when :emergency_contact_info
      if params.dig(:camp_user, :mailing_address).present? && params.dig(:camp_user, :emergency_contact).present?
        update_progress() if @camp_application.mailing_address.blank? && @camp_application.emergency_contact.blank?
        @camp_application.update(contact_info_params)
      end

    when :camp_activities
      if params.dig(:camp_user, :contribution).present?
        update_progress() if @camp_application.contribution.blank?
        @camp_application.update(camp_activities_params)
      end

    when :condition_of_health
      if params.dig(:camp_user, :health_condition).present?
        update_progress() if @camp_application.health_condition.blank?
        @camp_application.update_attribute(:health_condition, params.dig(:camp_user, :health_condition))
      end

    when :need_for_first_aid
      if params[:require_first_aid].present?
        update_progress() if @camp_application.require_first_aid.blank?
        @camp_application.update_attribute(:require_first_aid, params[:require_first_aid])
      end

    when :avail_food_Service
      if params[:avail_food_service].present?
        update_progress() if @camp_application.avail_food_service.blank?
        @camp_application.update_attribute(:avail_food_service, params[:avail_food_service])
      end

    when :avail_internet_service
      if params[:avail_internet_service].present?
        update_progress() if @camp_application.avail_internet_service.blank?
        @camp_application.update_attribute(:avail_internet_service, params[:avail_internet_service])
      end

    when :provide_social_media_info
      if params.dig(:camp_user, :social_media_handle).present?
        update_progress() if @camp_application.social_media_handle.blank?
        @camp_application.update_attribute(:social_media_handle, params.dig(:camp_user, :social_media_handle))
      end

    when :provide_side_note
      if params.dig(:camp_user, :side_note).present?
        update_progress() if @camp_application.side_note.blank?
        @camp_application.update_attribute(:side_note, params.dig(:camp_user, :side_note))
      end
    end

    render_wizard @camp_application
  end
  
  def find_application_for_user
    @user = current_user
    @camp_application = CampUser.find_by(user_id: @user.id)
    session[:registration_steps] = wizard_steps
  end

  private

  def contact_info_params
    params.require(:camp_user).permit(:mailing_address, :emergency_contact)
  end

  def camp_activities_params
    params.require(:camp_user).permit(:camp_activity, :contribution)
  end

  def user_params
    params.require(:camp_user).require(:user).permit(:firstname, :lastname, :email, :country, :contact)
  end

  def set_progress_bar
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

  def update_progress
    @camp_application.progress = @camp_application.progress + 10
    @camp_application.save()
  end
end
