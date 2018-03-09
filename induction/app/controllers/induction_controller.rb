class InductionController < ApplicationController
  
  def index
    unless params[:comment] == nil
      session[:comment] = params[:comment]
    end
    my_hash = (params[:json_data] == nil || params[:json_data] == "") ?
      nil : JSON.parse(params[:json_data])
    @responce = (my_hash == nil) ? nil : my_hash['parse']
    @comment = (session[:comment] == nil) ? 'text goes here' : session[:comment]
  end
  
end