require "json"
require_relative "Assumption.rb"
require_relative "EqExpression.rb"

class BaseCase

    def initialize(args,pk)
      @pk = pk
      @baseCase = JSON.parse(args)["baseCase"]
      
      raise RuntimeError, "Invalid baseCase request" unless not @baseCase.nil?
      
      @a = Assumption.new(@baseCase.to_json)
      
      @exp = EqExpression.new(@baseCase.to_json, @a)

      
        
    end

    def evaluate
        
        #evaluate pk with the assumption
         @pk_l = @pk.evaluate["left"].flat_map do |val|
            val == "n"? @a.evaluate.values[0] : val
         end
         
         e = Evaluator.new
        
        exp_s = @exp.getHead.clone
        
        
        ret = @exp.evaluate

        ret &= e.solve(exp_s) == e.solve(@pk_l)
       

        
        
        return ret
        
    end


end