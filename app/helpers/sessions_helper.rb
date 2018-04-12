module SessionsHelper
    def log_in(user)
        session[:user_id] = user.id
        session[:role] = user.role
        session[:user_name] = user.name
    end
    
    def log_out
        session.keys.each do |k|
            session[k] = nil
        end
    end
end
