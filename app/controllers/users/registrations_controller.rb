class Users::RegistrationsController < Devise::RegistrationsController
  before_action :update_allowed_parameters

  layout "users", except: [:new]

  protected
  
  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:firstname, :lastname, :email, :password, :country, :contact, :terms) }
  end
end
