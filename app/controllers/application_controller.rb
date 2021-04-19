class ApplicationController < ActionController::Base
  include Pagy::Backend

  require 'csv'

  protect_from_forgery with: :exception
end
