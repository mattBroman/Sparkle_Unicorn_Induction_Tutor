module SectionsHelper
    def set_class
        session[:section_id] = @section.id
    end
    
    def leave_class
        session[:section_id] = nil
    end
end
