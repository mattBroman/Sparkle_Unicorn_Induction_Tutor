require_relative "Base.rb" 
class Grader
    
    #pass json of problem here
   def initialize(args)
        
        @exception = nil
        
        begin
            @bc = BaseCase.new(args)
        
        rescue Exception => exc
            @exception = true
            @bc_exception = exc
        end
        
        #add inductive hypothesis and what not here later...
       
       
   
 end
    
    def evaluate
    
        #return any errors or the correct evaluation
        
        if !@exception.nil? then
            
            @bcval = @bc_exception.message unless @bc_exception.nil?
            
        else
            @bcval = @bc.evaluate
            
            
        end
        
        {:baseCase => @bcval}
        
    end
    
    
end