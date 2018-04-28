require "json"
require_relative "Assumption.rb"
require_relative "EqExpression.rb"
require_relative "MyErrors.rb"

class BaseCase


    @@basevalue = 1

    def initialize(args,pk)
      @pk = pk
      
      raise MissingError,"problem statement" unless not @pk.nil?

      
      @baseCase = JSON.parse(args)["baseCase"]
      raise MissingError,"Base Case" unless not @baseCase.nil?
      
      @a = Assumption.new(@baseCase.to_json)
      raise MissingError, "base case variable" unless not @a.nil?
      
      
      @eq_json = @baseCase["equivalenceExpressions"].to_json
      raise MissingError, "base case expression(s)" unless not @eq_json.nil?
      @exp = EqExpression.new(@eq_json, @a)

      @@basevalue = @a.evaluate.values[0]
      
        
    end

    def evaluate
        
        #obtain p(b) equation
         p @pk.evaluate(@a.evaluate.values[0])

         @pk_l = @pk.evaluate(@a.evaluate.values[0])["left"]
         raise IncorrectError, "base variable" unless not @pk_l.nil?
         p @pk_l
         p @pk.evaluate(@a.evaluate.values[0])
         
         e = Evaluator.new
        
        #first expression
        exp_s = @exp.getTail.clone
        raise MissingError, "base case expression(s)" unless not exp_s.empty? or not exp_s.nil?
        
        
        
        #all expressions in base case are equal
        ret = @exp.evaluate

        
        
        #the first expression and p(b) should be equal
        ret &= e.solve(exp_s) == e.solve(@pk_l)
      
        raise IncorrectError, "p(#{@a.evaluate.keys[0]}) differs from work" unless ret
      
      
        return ret
        
    end
    
    
    def self.getbasevalue
        
        return @@basevalue
        
    end


end