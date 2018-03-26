require "json"
require_relative "Assumption.rb"
require_relative "EqExpression.rb"

class BaseCase

    def initialize(args)
      
      @baseCase = JSON.parse(args)["baseCase"]
      
      a = Assumption.new(@baseCase.to_json)
      
      @exp = EqExpression.new(@baseCase.to_json, a)

       
        
    end

    def evaluate
       @exp.evaluate
    
    end


end