module TagsHelper
    def tags
        @tags = admin? ? Tag.all : Tag.where(user_id: session[:user_id])
    end
end
