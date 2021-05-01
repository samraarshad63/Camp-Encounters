class Admin::CampsController < AdminController
  before_action :authenticate_admin!

  def index
    @pagy, @camps = pagy(Camp.search(params[:keyword]), items: Camp::CAMPS_PER_PAGE)
  end

  def new
    @camp = Camp.new
  end

  def create
    @camp = Camp.new(camp_params)

    if @camp.save
      redirect_to admin_camps_path, notice: 'Camp added successfully'
    else
      render 'new'
    end
  end

  def change_camp_status
    @camp = Camp.find(params[:id])
    if @camp.status == "active"
      @camp.update(status: "inactive")
    else
      @camp.update(status: "active")
    end
    redirect_to admin_camps_path
  end

  private
  
  def camp_params
    params.require(:camp).permit(:id, :name, :start_date, :end_date, location_ids: [])
  end
end
