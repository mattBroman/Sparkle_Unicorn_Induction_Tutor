#Dir["../../lib/assets/*.rb"].each {|file| require_dependency file }
require_dependency '../../lib/assets/Grader.rb'
require_dependency '../../lib/assets/Base.rb'
require_dependency '../../lib/assets/Assumption.rb'
require_dependency '../../lib/assets/EqExpression.rb'
require_dependency '../../lib/assets/Evaluate.rb'

#require "#{Rails.root}/lib/assets/Grader"

class QuestionController < ApplicationController
  
  def index
    @questions = Question.all
  end
  
  def create
    begin
      parse = JSON.parse(params[:json_data])
      if parse['val'] == 'Bad'
        raise RuntimeError
      end
      @question = Question.new(question_params)
      @tags = Tag.where(id: params[:tags])
      @question.tags << @tags
      @question.save
    rescue RuntimeError
      flash[:notice] = 'invalid equations'
      redirect_to new_question_path
    #rescue
    #  flash[:notice] = 'Fields may not be blank'
    #  redirect_to new_question_path
    else
      flash[:notice] = "#{@question.title} was successfully created"
      redirect_to 
    end
  end
  
  def new
    @question = Question.new
    @options = User.find(session[:user_id])
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
      
    rescue Exception => e
      p e
      session[:responce] = e
    else
      session[:responce] = grader.evaluate
    end
    session[:comment] = (params[:comment] == nil) ? 'text goes here' : params[:comment]
    redirect_to question_path(params[:id])
  end

  def destroy
    question = Question.find(params[:id])
    @title = question.title
    question.destroy
    flash[:notice] = "#{@title} was deleted"
    redirect_to question_index_path
  end
  
  private
  def question_params
    params.require(:question).permit(:val, :title, :p_k, :implies, :difficulty, :user_id, :tags => [])
  end
  
end