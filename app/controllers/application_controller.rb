class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  layout :layout_by_resource

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  protected

  def layout_by_resource 
    if devise_controller?
      "devise_layout"
    else
      "application"
    end
  end
end
