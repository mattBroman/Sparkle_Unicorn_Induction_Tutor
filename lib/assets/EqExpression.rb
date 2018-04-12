require "json"
require_relative 'Evaluate.rb'

class EqExpression 
    
    
    
    
    
    def initialize(args, assumptions, symbolic=false, pk=nil)
        @symbolic = symbolic
        @pk = pk
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
        if(not  @symbolic) then
            @eqBlocks.each do |eqLine|
                eqLine["left"].each do |v|
                    raise RuntimeError, "Missing assumption(s)" unless not v =~ /[a-zA-Z]/
                end unless eqLine["left"].nil?
                eqLine["right"].each do |v|
                    raise RuntimeError, "Missing assumption(s)" unless not v =~ /[a-zA-Z]/
                end unless eqLine["right"].nil?
                
            end
        end
        

    end
    
    
    def evaluate
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
        
        
        return true
        
    
    end
    
    
    def getHead
       
       x = @eqBlocks[0]["left"] 
       
       return x
    end
    
    
    def headValid
        h = @eqBlocks.first.clone
        
        @pk_l = @pk.evaluate["left"].flat_map do |val|
            val == "n"? ["k","1","+"] : val
        end
        
        if (not(h["left"] == @pk_l)) then
            #left not equal
            return false
        end
        
        return true
    end
    
    def tailValid
        
        t = @eqBlocks.last.clone
        
        @pk_r = @pk.evaluate["right"].flat_map do |val|
            val == "n"? ["k","1","+"] : val
        end
        
        if(not(t["right"] == @pk_r)) then
            return false
        end        
        return true
        
    end



    def sym_evaluate 
        
        # #check first L with l_line
        # @pk_l = @pk.evaluate["left"].flat_map do |val|
        #     val == "n"? ["k","1","+"] : val
        # end

        # if (not(@eqBlocks[0]["left"] == @pk_l)) then
        #     #left not equal
        #     return false
        # end
        
        
        # #check last R with r_line
        
        # @pk_r = @pk.evaluate["right"].flat_map do |val|
        #     val == "n"? ["k","1","+"] : val
        # end
        
        # if(not(@eqBlocks.last["right"] == @pk_r)) then
        #     return false
        # end
        
        return false unless headValid==true
        return false unless tailValid==true

        
        #check all lines are symblically equal
        
        base = @eqBlocks[0]["left"]
        same = true
        @eqBlocks.each do |eql|
            same &= sym_eq_equal(base,eql["left"]) unless eql["left"]==[]
            same &= sym_eq_equal(base,eql["right"])
        end
        return same
        
    end



    #stubbed with a simple eqn    
    def sym_eq_equal(base,eqn)
        return sym_eq_equal_simple(base,eqn)

    end
    
    
    
    #simple check
    def sym_eq_equal_simple(base, eqn)
        tvals = ["1","2","3","4","5"]
        same = true
        
        eval = Evaluator.new

        
        tvals.each do |t|
           z = base.map{|x| x =="k" ? t : x}
           y = eqn.map{|x| x =="k" ? t : x}
           same &= (eval.solve(z) == eval.solve(y))
        end
        
        return same
  
        
    end
    


    
end



    
    
