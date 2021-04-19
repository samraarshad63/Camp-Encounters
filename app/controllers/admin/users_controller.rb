class Admin::UsersController < AdminController
  include Sortable

  require 'csv'
  
  helper_method :sort_column, :sort_direction

  before_action :authenticate_admin!
  before_action :find_user, except: [:index]

  def index
    @pagy, @users = pagy(User.search(params[:keyword]), items: User::PER_PAGE)

    if sort_column(@users).present? && sort_direction.present?
      @users = @users.order(sort_column(@users) + ' ' + sort_direction)
    end

    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"user-list\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:keyword)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
