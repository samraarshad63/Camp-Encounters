class PagesController < ApplicationController
  def show
    return redirect_to home_index_url, alert: 'Page does not exist' unless lookup_context.template_exists?("pages/#{params[:page]}")
    
    render template: "pages/#{params[:page]}"
  end
end
