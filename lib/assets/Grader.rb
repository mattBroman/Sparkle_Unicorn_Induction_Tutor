require_relative "Base.rb" 
require_relative "IStep.rb" 

class Grader
    
    #pass json of problem here
   def initialize(args,pk=nil)
        
        @pk = pk
        
        
        #check the base case
        begin
          
            @bc = BaseCase.new(args,@pk)
        
        rescue Exception => exc
            @bc_exception = exc
        end
        
        
        #check the inductive step
        begin
            
            @istep = IStep.new(args,@pk)
            
        rescue Exception => exc
            @is_exception = exc
        end
        

       
   
 end
    
    def evaluate
    
        if(@bc_exception.nil?) then
            
            @bcval = @bc.evaluate
            
        else
            @bcval = @bc_exception.message
            
        end
        
        
        if(@is_exception.nil?) then
            
            @istepval = @istep.evaluate
            
        else
            @istepval = @is_exception.message
            
        end
        
    
        {:baseCase => @bcval, :ihypothesis=>@istepval}
        
    end
    
    
end