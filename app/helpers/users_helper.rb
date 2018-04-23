module UsersHelper
    def admin?
        session[:role] && session[:role] >= 1000
    end
    
    def teacher?
        session[:role] && session[:role] >= 100
    end
    
    def student?
        session[:role] && session[:role] >= 10
    end
    
    def is_admin?
        session[:role] && session[:role] == 1000
    end
    
    def is_teacher?
        session[:role] && session[:role] == 100
    end
    
    def is_student?
        session[:role] && session[:role] == 10
    end
end
