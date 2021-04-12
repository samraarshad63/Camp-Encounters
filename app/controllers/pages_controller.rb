class PagesController < ApplicationController
  def show
  	if lookup_context.template_exists?("pages/#{params[:page]}")
  		render template: "pages/#{params[:page]}"
    else
    	redirect_to home_index_url
    end
  end
end
