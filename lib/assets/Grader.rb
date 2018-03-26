require_relative "Base.rb" 
class Grader
    
    #pass json of problem here
   def initialize(args)
    
       # p args.to_s
          
      @bc = BaseCase.new(args)
      
      #add inductive hypothesis and what not here later...
       
       
       
   end
    
    def evaluate
        @bc.evaluate
    end
    
    
end