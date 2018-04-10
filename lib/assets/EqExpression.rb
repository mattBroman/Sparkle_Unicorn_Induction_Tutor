require "json"
require_relative 'Evaluate.rb'

class EqExpression 
    
    
    
    
    
    def initialize(args, assumptions)
        
        @eqBlocks = JSON.parse(args)["equivalenceExpressions"]
        
        raise RuntimeError, "Missing expression(s)" unless not @eqBlocks.nil?
        
        @assumptions = assumptions
        raise RuntimeError, "Missing assumption(s)" unless not @assumptions.evaluate.empty?
        
        #add assumptions to eq's
        @assumptions.evaluate.each do |key,val|
            
            
            # index of val[i] is 0 for now because we assume assumptions are raw values and not expressions
            @eqBlocks.each do |eqLine|
                    eqLine["left"].map! { |x|
                        x==key.to_s ? val[0] : x
                    } unless eqLine["left"].nil?
                    eqLine["right"].map! { |x|
                        x==key.to_s ? val[0] : x
                    } unless eqLine["right"].nil?
            end
           
        end
        
        #variables still left in expressions
        @eqBlocks.each do |eqLine|
            eqLine["left"].each do |v|
                raise RuntimeError, "Missing assumption(s)" unless not v =~ /[a-zA-Z]/
            end unless eqLine["left"].nil?
            eqLine["right"].each do |v|
                raise RuntimeError, "Missing assumption(s)" unless not v =~ /[a-zA-Z]/
            end unless eqLine["right"].nil?
            
        end
        
    

    end
    
    
    def evaluate
       eval = Evaluator.new
        p @eqBlocks
        val = eval.solve(@eqBlocks[0]["left"])
        
        
       
        
       @eqBlocks.each do |eqLine|
            if(not(val == eval.solve(eqLine["right"]))) then

                return false
            
            end
            
            if not eqLine["left"].nil?  and not eqLine["left"].empty? then
                
                if(not(val==eval.solve(eqLine["left"]))) then
                    return false
                end
            
                
            end    
           
       end
        
        
        return true
        
    
    end
    
end

    
    
