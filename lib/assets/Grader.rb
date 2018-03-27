require_relative "Base.rb" 
class Grader
    
    #pass json of problem here
   def initialize(args)
    
       # p args.to_s
        begin
            @bc = BaseCase.new(args)
        rescue
            @bc = nil
        end
      
      #add inductive hypothesis and what not here later...
       
       
       
   end
    
    def evaluate
        begin
            @bc.evaluate
        rescue
            return 'bad'
        else
            return 'good'
        end
    end
    
    
end