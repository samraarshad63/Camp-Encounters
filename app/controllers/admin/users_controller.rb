class Admin::UsersController < AdminController
  include Sortable

  require 'csv'
  require 'pagy/extras/bootstrap'
  
  helper_method :sort_column, :sort_direction

  before_action :authenticate_admin!
  before_action :find_user, except: [:index]

  def index
    @csv_users_list = User.all
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
    update =
        if params.dig(:user, :password).blank?
          @user.update_without_password(update_user_params)
        else
          @user.update(update_user_params)
        end

    return redirect_to admin_users_path, notice: 'User profile updated successfully' if update

    render 'edit'
  end

  def destroy
    if @user.destroy
      flash[:notice] = 'User destroyed successfully'
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
    end
    redirect_to admin_users_path
  end

  private
  
  def user_params
    params.require(:user).permit(:keyword)
  end

  def update_user_params
    params.require(:user).permit(:id, :firstname, :lastname, :email, :password, :country, :contact)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
