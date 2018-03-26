require "json"
require_relative "Assumption.rb"
require_relative "EqExpression.rb"

class BaseCase

    def initialize(args)
      
      @baseCase = JSON.parse(args)["baseCase"]
      
      raise RuntimeError, "Invalid JSON request for baseCase" unless not @baseCase.nil?
      
      a = Assumption.new(@baseCase.to_json)
      
      @exp = EqExpression.new(@baseCase.to_json, a)

       
        
    end

    def evaluate
       @exp.evaluate
    
    end


end