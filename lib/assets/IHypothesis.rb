require "json"
require_relative "Pk.rb"
require_relative "Assumption.rb" 

require_relative "Assume.rb" 

class IHypothesis
    
   def initialize(args,pk)
       
        @pk = pk

        @ih = JSON.parse(args)["IHypothesis"]
        
        @assumptions = Assumption.new(@ih.to_json)

        
        @assume = Assume.new(@ih.to_json, @assumptions, @pk)
        

 end
    
    def evaluate

        @assume.evaluate

    end
    
    
end