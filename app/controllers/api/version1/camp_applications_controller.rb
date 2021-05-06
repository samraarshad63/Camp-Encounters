class Api::Version1::CampApplicationsController < Api::BaseController
  def show
    @application = CampUser.find(params[:id])
    render json: {camp_application: @application}
  end

  def create
    @application = CampUser.new(camp_users_params)
    @application.save()
    render json: {camp_application: @application}
  end

  private

  def camp_users_params
    params.permit(:camp_id, :user_id)
  end
end
