module Registrable
  extend ActiveSupport::Concern
  
  included do
    def update_steps
      case step
      when :personal_info
        @user.update(user_params)
        return if params[:gender].blank? && (!@camp_application.user_image.attached? || params.dig(:camp_user, :user_image).blank?)

        update_progress = @camp_application.gender.blank?
        params_hash = {gender: params[:gender]}
        @camp_application.user_image.purge if @camp_application.user_image.attached? && params.dig(:camp_user, :user_image).present?
        @camp_application.user_image.attach(params.dig(:camp_user, :user_image)) if params.dig(:camp_user, :user_image).present?

      when :emergency_contact_info
        return if params.dig(:camp_user, :mailing_address).blank? || params.dig(:camp_user, :emergency_contact).blank?

        update_progress = @camp_application.mailing_address.blank? && @camp_application.emergency_contact.blank?
        params_hash = {mailing_address: params.dig(:camp_user, :mailing_address), emergency_contact: params.dig(:camp_user, :emergency_contact)}

      when :camp_activities
        return if params.dig(:camp_user, :contribution).blank?

        update_progress = @camp_application.contribution.blank?
        params_hash = {contribution: params.dig(:camp_user, :contribution), camp_activity: params.dig(:camp_user, :camp_activity)}

      when :condition_of_health
        return if params.dig(:camp_user, :health_condition).blank?
          
        update_progress = @camp_application.health_condition.blank?
        params_hash = {health_condition: params.dig(:camp_user, :health_condition)}

      when :need_for_first_aid
        return if params[:require_first_aid].blank?

        update_progress = @camp_application.require_first_aid.blank?
        params_hash = {require_first_aid: params[:require_first_aid]}

      when :avail_food_Service
        return if params[:avail_food_service].blank?
          
        update_progress = @camp_application.avail_food_service.blank?
        params_hash = {avail_food_service: params[:avail_food_service]}

      when :avail_internet_service
        return if params[:avail_internet_service].blank?

        update_progress = @camp_application.avail_internet_service.blank?
        params_hash = {avail_internet_service: params[:avail_internet_service]}

      when :provide_social_media_info
        return if params.dig(:camp_user, :social_media_handle).blank?

        update_progress = @camp_application.social_media_handle.blank?
        params_hash = {social_media_handle: params.dig(:camp_user, :social_media_handle)}

      when :provide_side_note
        return if params.dig(:camp_user, :side_note).blank?

        update_progress = @camp_application.side_note.blank?
        params_hash = {side_note: params.dig(:camp_user, :side_note)}

      when :confirm_camp_registration
        if @camp_application.progress == 90 
          params_hash = {submitted: true}
        else 
          jump_to(:confirm_camp_registration)
          flash[:notice] =  'Please complete your application before submitting.'
        end     
      end

      ActiveRecord::Base.transaction do
        @camp_application.update(params_hash) if params_hash
        @camp_application.update_progress if update_progress
      end

      @camp_application
    end
  end
end
