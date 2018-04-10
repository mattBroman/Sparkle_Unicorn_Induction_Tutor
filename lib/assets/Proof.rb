require "json"
require_relative "Pk.rb"
require_relative "Assumption.rb"
require_relative "EqExpression.rb"

class Proof
    
    def initialize(args)
       @proof = JSON.parse(args)["proof"]
       
       @pk = Pk.new(args)
       
       @assumptions = Assumption.new(@proof.to_json)
       
       @eqs = EqExpression.new(@proof.to_json,@assumptions,true,@pk)
    
    
    end
    
    def evaluate
        
        if(@assumptions.evaluate != {"n"=>["k","1","+"]}) then
           return false 
        end
        
        
        
        return @eqs.evaluate
    
    
    end

    
end