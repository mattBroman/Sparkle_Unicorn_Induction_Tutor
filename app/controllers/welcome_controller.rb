class WelcomeController < ApplicationController
  def index
    if session[:user_id] != nil
      redirect_to user_path(session[:user_id])
    end
  end
end

