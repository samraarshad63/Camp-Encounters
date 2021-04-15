class Admin::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(current_user)
    admin_path(current_user)
  end

  def after_sign_up_path_for(current_user)
    admin_path(current_user)
  end

  def after_sign_out_path_for(current_user)
    home_path
  end
end
