class Users::RegistrationsController < Devise::RegistrationsController
  before_action :update_allowed_parameters

  layout "users", except: [:new]

  def update
    update =
        if params.dig(:user, :password).blank?
          @user.update_without_password(user_params)
        else
          @user.update(user_params)
        end

    return redirect_to user_path(current_user), notice: 'Profile updated successfully' if update
    
    render 'edit'
  end

  protected
  
  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:firstname, :lastname, :email, :password, :country, :contact, :terms) }
  end

  def user_params
      params.require(:user).permit(:id, :firstname, :lastname, :email, :password, :country, :contact)
  end
end
