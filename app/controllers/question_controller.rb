#Dir["../../lib/assets/*.rb"].each {|file| require_dependency file }
require_dependency '../../lib/assets/Pk.rb'
require_dependency '../../lib/assets/Grader.rb'
require_dependency '../../lib/assets/Base.rb'
require_dependency '../../lib/assets/Assumption.rb'
require_dependency '../../lib/assets/EqExpression.rb'
require_dependency '../../lib/assets/Evaluate.rb'
require_dependency '../../lib/assets/IHypothesis.rb'
require_dependency '../../lib/assets/Assume.rb'


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
      if params[:tags]
        @tags = Tag.where(id: params[:tags].keys)
        @question.tags << @tags
      end
      @question.save
    rescue RuntimeError
      flash[:notice] = 'invalid equations'
      redirect_to new_question_path
    #rescue
    #  flash[:notice] = 'Fields may not be blank'
    #  redirect_to new_question_path
    else
      flash[:notice] = "#{@question.title} was successfully created"
      redirect_to user_path(session[:user_id])
    end
  end
  
  def new
    @question = Question.new
    @new = true
    @url = create_question_path
    @tags = admin? ? Tag.all : Tag.where(user_id: session[:user_id])
  end
  
  def edit
    @question = Question.find(params[:id])
    @url = update_question_path([params[:id]])
    @tags = admin? ? Tag.all : Tag.where(user_id: session[:user_id])
  end
  
  def update
    @question = Question.find(params[:id])
    @question.update(question_params)
    @question.tags.destroy_all
    if params[:tags]
      @tags = Tag.where(id: params[:tags].keys)
      @question.tags << @tags
    end
    redirect_to user_path(session[:user_id])
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
      pk = Pk.new(@question.p_k, @question.implies)
      grader = Grader.new(params[:json_data],pk)
      
    rescue Exception => e
      p e
      session[:responce] = nil
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
    redirect_to user_path(session[:user_id])
  end
  
  private
  def question_params
    params.require(:question).permit(:val, :title, :p_k, :implies, :difficulty, :user_id, :tags => [])
  end
  
end