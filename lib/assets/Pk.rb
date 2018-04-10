#require_relative "Assumption.rb" 
require_relative "Evaluate.rb" 

class Pk
    
    def initialize(pkl,pkr)
        e = Evaluator.new
        
        lv = e.shunting_yard(pkl.chars)
        rv = e.shunting_yard(pkr.chars)
        @pk = {"left"=>lv, "right"=>rv}
    end
    
    
    def evaluate
        @pk
        
    end
    
    
end