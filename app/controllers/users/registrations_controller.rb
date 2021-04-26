class Users::RegistrationsController < Devise::RegistrationsController
  before_action :update_allowed_parameters

  layout "users", except: [:new]

  def update
    if @user.update(user_params)
      redirect_to user_path(current_user)
      flash[:notice] = "Profile updated"
    else
      render 'edit'
      flash[:alert] = "Couldnt save changes.Try again."
    end
  end

  protected
  
  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:firstname, :lastname, :email, :password, :country, :contact, :terms) }
  end

  def user_params
    if params[:user][:password].blank?
      params.require(:user).permit(:id, :firstname, :lastname, :email, :country, :contact)
    else
      params.require(:user).permit(:id, :firstname, :lastname, :email, :password, :country, :contact)
    end
  end
end
