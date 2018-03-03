class WelcomeController < ApplicationController
  def index
    unless params[:comment] == nil
      session[:comment] = params[:comment]
    end
    unless session[:comment] == nil
      @text = validate(tokenize(session[:comment]))
      @comment = session[:comment]
    else 
      @text = ''
      @comment = 'text goes here'
    end
  end
end

def tokenize input
  input.split
end

def validate input
  markers = ['<basis>', '</basis>', '<induction>', '</induction>']
  valid = true
  
  for i in markers
    valid &= input.include?(i)
  end
  
  valid ? 'valid' : 'invalid'
end 

