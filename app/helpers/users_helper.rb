module UsersHelper
    def admin?
        session[:role] >= 1000
    end
    
    def teacher?
        session[:role] >= 100
    end
    
    def student?
        session[:role] >= 10
    end
    
end
