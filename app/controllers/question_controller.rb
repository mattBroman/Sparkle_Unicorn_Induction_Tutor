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
      flash[:notice] = 'Feilds may not be blank'
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
    @responce = params[:responce]
    @comment = params[:comment]
  end
  
  def grade
    @question = Question.find(params[:id])
    my_hash = (params[:json_data] == nil || params[:json_data] == "") ?
      nil : JSON.parse(params[:json_data])
    responce = (my_hash == nil) ? '' : my_hash['parse']
    #json_ex = {:baseCase => {:assumptions => [{:b=>3}], :equivalenceExpressions => [{:left=>["b", "4", "5", "*","+"], :right=>["b", "20", "+"]}]}}.to_json
    #g = Grader.new(json_ex)
    responce = g.evaluate.to_s
    comment = (params[:comment] == nil) ? 'text goes here' : params[:comment]
    redirect_to question_path(params[:id], :comment => comment, :responce => responce)
  end
  
  private
  def question_params
    params.require(:question).permit(:val, :title, :p_k, :implies, :difficulty)
  end
  
end