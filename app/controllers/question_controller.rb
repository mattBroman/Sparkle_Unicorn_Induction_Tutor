#Dir["../../lib/assets/*.rb"].each {|file| require_dependency file }
require_dependency '../../lib/assets/Pk.rb'
require_dependency '../../lib/assets/Base.rb'
require_dependency '../../lib/assets/Assumption.rb'
require_dependency '../../lib/assets/EqExpression.rb'
require_dependency '../../lib/assets/Evaluate.rb'
require_dependency '../../lib/assets/Hypothesis.rb'
require_dependency '../../lib/assets/Assumption.rb'
require_dependency '../../lib/assets/MyErrors.rb'
require_dependency '../../lib/assets/Show.rb'
require_dependency '../../lib/assets/Uih.rb'
require_dependency '../../lib/assets/Grader.rb'
require_dependency '../../lib/assets/IStep.rb'



#require "#{Rails.root}/lib/assets/Grader"

class QuestionController < ApplicationController
  
  def admin_index
    if admin?
      session[:page] = "Questions"
      session[:back] = admin_questions_path(admin: true)
      @questions = Question.all
    end
  end
  
  def index
    session[:page] = "My Questions"
    session[:back] = question_index_path
    @questions = Question.where(user_id: session[:user_id])
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
      redirect_to session[:back]
    end
  end
  
  def new
    @question = Question.new
    @new = true
    @url = create_question_path
    @tags = Tag.where(user_id: session[:user_id])
  end
  
  def edit
    @question = Question.find(params[:id])
    @url = update_question_path([params[:id]])
    @tags = Tag.where(user_id: @question.user_id)
  end
  
  def update
    @question = Question.find(params[:id])
    @question.update(question_params)
    @question.tags.destroy_all
    if params[:tags]
      @tags = Tag.where(id: params[:tags].keys)
      @question.tags << @tags
    end
    redirect_to session[:back]
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
      @responce = grader.evaluate
      session[:responce] = @responce
    end
    session[:comment] = (params["set-size"] == nil) ? 'text goes here' : params["set-size"]
    @attempt = Attempt.new
    @attempt.correct = @responce[:correct]
    @attempt.basis = @responce[:baseCase][:result]
    @attempt.inductiveStep = @responce[:inductiveStep][:result]
    @attempt.ih = @responce[:inductiveStep][:hypothesis][:result]
    @attempt.toShow = @responce[:inductiveStep][:toShow][:result]
    @attempt.rawVal = params["set-size"]
    @attempt.user_id = session[:user_id]
    @attempt.question_id = @question.id
    @attempt.save
    redirect_to question_path(params[:id])
  end
  
  ####   
  #      {
  #          :correct => @correct,
  #          :baseCase => {
  #              :result=>@bcval,
  #              :error=>@bc_exception
  #          },
  #          :inductiveStep=>{
  #              :result=>@istepval,
  #              :error=>@is_exception,
  #              :hypothesis=>{
  #                  :result=>@hypothesisval,
  #                  :error=>@hypothesis_exception
  #              },
  #              :toShow=>{
  #                  :result=>@toshowval,
  #                  :error=>@toshow_exception
  #              }
  #          }
  #      }

  def destroy
    question = Question.find(params[:id])
    @title = question.title
    question.destroy
    flash[:notice] = "#{@title} was deleted"
    redirect_to session[:back]
  end
  
  private
  def question_params
    params.require(:question).permit(:val, :title, :p_k, :implies, :difficulty, :user_id, :tags => [])
  end
  
end