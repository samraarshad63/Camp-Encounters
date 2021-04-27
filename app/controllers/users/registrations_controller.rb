class Users::RegistrationsController < Devise::RegistrationsController
  before_action :update_allowed_parameters

  layout "users", except: [:new]

  def update
    if params.dig(:user, :password).blank?
      if @user.update_without_password(user_params)
        redirect_to user_path(current_user), notice: 'Profile updated successfully'
      else
        render 'edit'
      end
    else
      if @user.update(user_params)
        redirect_to user_path(current_user), notice: 'Profile updated successfully'
      else
        render 'edit'
      end
    end
  end

  protected
  
  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:firstname, :lastname, :email, :password, :country, :contact, :terms) }
  end

  def user_params
      params.require(:user).permit(:id, :firstname, :lastname, :email, :password, :country, :contact)
  end
end
