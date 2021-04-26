class Admin::UsersController < AdminController
  include Sortable

  require 'csv'
  
  helper_method :sort_column, :sort_direction

  before_action :authenticate_admin!
  before_action :find_user, except: [:index]

  def index
    @all_users = User.all
    @pagy, @users = pagy(User.search(params[:keyword]), items: User::PER_PAGE)

    if sort_column(@users).present? && sort_direction.present?
      @users = @users.order(sort_column(@users) + ' ' + sort_direction)
    end
    
    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"CM-user-list\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(update_user_params)
      redirect_to admin_users_path
    else
      render 'edit'
      flash[:alert] = "Couldnt save changes.Try again."
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  private
  
  def user_params
    params.require(:user).permit(:keyword)
  end

  def update_user_params
    if params[:user][:password].blank?
      params.require(:user).permit(:id, :firstname, :lastname, :email, :country, :contact)
    else
      params.require(:user).permit(:id, :firstname, :lastname, :email, :password, :country, :contact)
    end
  end

  def find_user
    @user = User.find(params[:id])
  end
end
