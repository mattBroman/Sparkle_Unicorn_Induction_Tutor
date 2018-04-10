require_relative "Base.rb" 
require_relative "IHypothesis.rb" 
require_relative "Proof.rb" 

class Grader
    
    #pass json of problem here
   def initialize(args,pk=nil)
        @pk = pk
        
        @exception = nil
        
        begin
          
            @bc = BaseCase.new(args)
            @ih = IHypothesis.new(args,@pk)
        
        rescue Exception => exc
            @exception = true
            @bc_exception = exc
        end
        
        #add inductive hypothesis and what not here later...
       
       
   
 end
    
    def evaluate
    
        #return any errors or the correct evaluation
        if(not (@exceptiopn)) then
            
            @bcval = @bc.evaluate
            @ihval = @ih.evaluate
        end

        
        {:baseCase => @bcval, :ihypothesis=>@ihval}
        
    end
    
    
end