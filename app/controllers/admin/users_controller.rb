class Admin::UsersController < AdminController
  before_action :authenticate_admin!

  def index
    @pagy, @users = pagy(User.search(params[:keyword]), items: User::PER_PAGE)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
   
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
end
