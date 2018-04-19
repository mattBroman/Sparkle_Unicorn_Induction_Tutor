require "json"
require_relative "Assumption.rb"
require_relative "EqExpression.rb"

class BaseCase

    def initialize(args,pk)
      @pk = pk
      @baseCase = JSON.parse(args)["baseCase"]
      
      raise RuntimeError, "Invalid baseCase request" unless not @baseCase.nil?
      
      @a = Assumption.new(@baseCase.to_json)
      
      
      @eq_json = @baseCase["equivalenceExpressions"].to_json
      
      @exp = EqExpression.new(@eq_json, @a)

      
        
    end

    def evaluate
        
        #obtain p(b) equation
         @pk_l = @pk.evaluate(@a.evaluate.values[0])["left"]
         
         
         e = Evaluator.new
        
        #first expression
        exp_s = @exp.getTail.clone
        
        
        #all expressions in base case are equal
        ret = @exp.evaluate

        
        
        #the first expression and p(b) should be equal
        ret &= e.solve(exp_s) == e.solve(@pk_l)
      
      
      
      
        return ret
        
    end


end