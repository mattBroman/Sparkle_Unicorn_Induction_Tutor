class SessionsController < ApplicationController
  def create
  end

  def destroy
  end
end


class SessionsController < ApplicationController
  def create 
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = use.id
    redirect_to root_path
  end
    
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
    
end
