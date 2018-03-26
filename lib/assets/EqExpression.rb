require "json"
require_relative 'Evaluate.rb'

class EqExpression 
    
    
    
    
    
    def initialize(args, assumptions)
        
        @eqBlocks = JSON.parse(args)["equivalenceExpressions"]
        
        raise RuntimeError, "Invalid EqExpression request" unless not @eqBlocks.nil?
        
        @assumptions = assumptions
        raise RuntimeError, "Missing assumption(s)" unless not @assumptions.evaluate.empty?
        
        #add assumptions to eq's
        @assumptions.evaluate.each do |assumption|
            assumption.each do |key,val|
                @eqBlocks.each do |eqLine|
                        eqLine["left"].map! { |x|
                            x==key.to_s ? val.to_s : x
                        }
                        eqLine["right"].map! { |x|
                            x==key.to_s ? val.to_s : x
                        }
                end
            end
        end
        
        #variables still left in expressions
        @eqBlocks.each do |eqLine|
            eqLine["left"].each do |v|
                raise RuntimeError, "Missing assumption(s)" unless not v =~ /[a-zA-Z]/
            end
            eqLine["right"].each do |v|
                raise RuntimeError, "Missing assumption(s)" unless not v =~ /[a-zA-Z]/
            end
            
        end
        
    

    end
    
    
    def evaluate
       eval = Evaluator.new
        
        val = eval.solve(@eqBlocks[0]["left"])
        
       
        
       @eqBlocks.each do |eqLine|
            if(not(val == eval.solve(eqLine["right"]))) then

                return false
            
            end
            
            if not eqLine["left"].empty? then
                
                if(not(val==eval.solve(eqLine["left"]))) then
                    return false
                end
            
                
            end    
           
       end
        
        
        return true
        
    
    end
    
end

    
    
