require_relative '../../lib/assets/Grader'

#require "#{Rails.root}/lib/assets/Grader"

class QuestionController < ApplicationController
  
  def index
    @questions = Question.all
  end
  
  def create
    begin
      @question = Question.create!(question_params)
    rescue 
      flash[:notice] = 'Fields may not be blank'
      redirect_to new_question_path
    else
      flash[:notice] = '#{@question.title} was successfully created'
      redirect_to question_index_path
    end
  end
  
  def new
    @question = Question.new
  end
  
  def show
    @question = Question.find(params[:id])
    @responce = session[:responce]
    @comment = session[:comment]
  end
  
  def grade
    @question = Question.find(params[:id])
    #my_hash = (params[:json_data] == nil || params[:json_data] == "") ?
    #  nil : JSON.parse(params[:json_data])
    #responce = (my_hash == nil) ? '' : my_hash['parse']
    begin
      grader = Grader.new params[:json_data]
    rescue
      session[:responce] = 'Bad!'
    else
      session[:responce] = grader.evaluate
    end
    session[:comment] = (params[:comment] == nil) ? 'text goes here' : params[:comment]
    redirect_to question_path(params[:id])
  end
  
  private
  def question_params
    params.require(:question).permit(:val, :title, :p_k, :implies, :difficulty)
  end
  
end