module SessionsHelper
    def log_in(user)
        session[:user_id] = user.id
        session[:role] = user.role
    end
    
    def log_out
        session[:user_id] = nil
        session[:role] = nil
    end
end
