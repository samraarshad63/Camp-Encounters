class Admin::CampApplicationsController < AdminController
  def index
    @applications = CampUser.all
  end

  def show
     @application = CampUser.find(params[:id])
  end
end
