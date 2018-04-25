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

end