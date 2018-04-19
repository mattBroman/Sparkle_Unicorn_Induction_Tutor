require "json"
require_relative 'Evaluate.rb'

class EqExpression 
    
    
    
    
    
    def initialize(args, assumptions, symbolic=false, pk=nil)
        @symbolic = symbolic
        @pk = pk
        @eqBlocks = JSON.parse(args)
        
        raise RuntimeError, "Missing expression(s)" unless not @eqBlocks.nil?
        
        @assumptions = assumptions
        #raise RuntimeError, "Missing assumption(s)" unless not @assumptions.evaluate.empty?
        
        #if no assumptions and not symbolic throw error
        
        if(not symbolic) then
        
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
        
        
            @eqBlocks.each do |eqLine|
                eqLine["left"].each do |v|
                    raise RuntimeError, "Missing assumption(s)" unless not v =~ /[a-zA-Z]/
                end unless eqLine["left"].nil?
                eqLine["right"].each do |v|
                    raise RuntimeError, "Missing assumption(s)" unless not v =~ /[a-zA-Z]/
                end unless eqLine["right"].nil?
                
            end
        else
            #check if only k is used if symbolic
           
            
        
        end
        

    end
    
    
    def evaluate
        
        tmp = @eqBlocks.clone
        
        if(@symbolic) then 
            return sym_evaluate()
        end
        
       eval = Evaluator.new
         
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
        
        @eqBlocks = tmp
        return true
        
    
    end
    
    
    def getTail
       # p "last---"
       #p @eqBlocks.last.clone["right"]
       #p "---"
       x = @eqBlocks.last.clone
       return x["right"] 
       
    end
    
    
    def headValid
        h = @eqBlocks.first.clone
        
        @pk_l = @pk.evaluate(["k","1","+"])["left"]
        
        if (not(h["left"] == @pk_l)) then
            return false
        end
        
        return true
    end
    
    def tailValid
        
        t = @eqBlocks.last.clone
        
        @pk_r = @pk.evaluate(["k","1","+"])["right"]
        
#        p t["right"]
 #       p @pk_r
        
        
        if(not(t["right"] == @pk_r)) then
            return false
        end       
        
        return true
        
    end



    def sym_evaluate(base)
        e = Evaluator.new
        #check all lines are symblically equal
        same = true
        @eqBlocks.each do |eql|
            same &= e.sym_eq_equal(base,eql["left"]) unless eql["left"]==[] or eql["left"].nil?
            same &= e.sym_eq_equal(base,eql["right"])
        end
        return same
        
    end




    


    
end



    
    
