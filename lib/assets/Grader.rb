class Grader
    
    #pass json of problem here
   def initialize(args)
    
    
          
      @bc = BaseCase.new(args)
      
      #add inductive hypothesis and what not here later...
       
       
       
   end
    
    def evaluate
        @bc.evaluate
    end
    
    
end