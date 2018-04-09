#require_relative "Assumption.rb" 
class Pk
    
    def initialize(args)
        @pk = JSON.parse(args)["pk"]
    end
    
    
    def evaluate
        @pk
        
    end
    
    
end