class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
<<<<<<< HEAD
  include SessionsHelper
  include UsersHelper
  include SectionsHelper
  include TagsHelper
=======
  helper_method :current_user
  
  def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
>>>>>>> google-login
  
end
