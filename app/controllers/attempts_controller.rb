class AttemptsController < ApplicationController

    def destroy
        @attempt = Attempt.find(params[:id])
        @attempt.destroy
        respond_to do |format|
          format.html { redirect_to session[:back], notice: 'Attempt was successfully destroyed.' }
          format.json { head :no_content }
        end
    end
    
    def show
        @attempt = Attempt.find(params[:id])
        @question = Question.where(id: @attempt.question_id).first
    end
    
    def index
        if teacher? or session[:user_id] == params[:user_id].to_i
            @attempts = Attempt.where(user_id: params[:user_id]).order("created_at").reverse
        end
    end

end