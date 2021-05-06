class Admin::CampApplicationsController < AdminController
  before_action :find_application, except: [:index]

  def index
    @applications = CampUser.all
  end

  def show; end

  def edit; end

  def update
  end

  def destroy
    if @application.destroy
      flash[:notice] = 'Application destroyed successfully'
    else
      flash[:alert] = @application.errors.full_messages.to_sentence
    end
    redirect_to admin_camp_applications_path
  end

  def find_application
     @application = CampUser.find(params[:id])
  end
end
