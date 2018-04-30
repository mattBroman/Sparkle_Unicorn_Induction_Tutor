require_relative "Base.rb" 
require_relative "IStep.rb" 


class Grader
    
    #pass json of problem here
   def initialize(args,pk=nil)
        
        @pk = pk
        
        
        #check the base case
        begin
          
            @bc = BaseCase.new(args,@pk)
            @bcval = @bc.evaluate

        
        rescue => exc
            @bc_exception = exc.message
        end
        
        
        #check the inductive step
        begin
            @istep_json = JSON.parse(args)["inductiveStep"].to_json

            @istep = IStep.new(args,@pk)
           
            if not @istep.nil? 
                @istepval = @istep.evaluate
            end
        rescue => exc
            @is_exception = exc.message
        end
        
        
       
        begin
            
            @hypothesisval = Hypothesis.new(@istep_json, @pk).evaluate

            #@hypothesisval = @istep.evaluate_hypothesis    
        rescue => exc
            @hypothesis_exception = exc.message
        end
        
        begin
            @toshowval = Show.new(@istep_json, @pk).evaluate

            #@toshowval = @istep.evaluate_show    
        rescue => exc
            @toshow_exception = exc.message
        end
        
        
        @bcval = false unless not @bc_exception
        @istepval = false unless not @is_exception
        @hypothesisval = false unless not @hypothesis_exception
        @toshowval = false unless not @toshow_exception
        
        

       @correct = @bcval & @istepval & @hypothesisval & @toshowval
   
   end
    
    def evaluate

    
        {
            :correct => @correct,
            :baseCase => {
                :result=>@bcval,
                :error=>@bc_exception
            },
            :inductiveStep=>{
                :result=>@istepval,
                :error=>@is_exception,
                :hypothesis=>{
                    :result=>@hypothesisval,
                    :error=>@hypothesis_exception
                },
                :toShow=>{
                    :result=>@toshowval,
                    :error=>@toshow_exception
                }
            }
        }
        
    end
    
    
    
end