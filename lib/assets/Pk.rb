#require_relative "Assumption.rb" 
require_relative "Evaluate.rb" 

class Pk
    
    def initialize(pkl,pkr)
        e = Evaluator.new
        pkl=e.tokenize(pkl)
        pkr=e.tokenize(pkr)
        lv = e.shunting_yard(pkl)
        rv = e.shunting_yard(pkr)
        @pk = {"left"=>lv, "right"=>rv}
    end
    
    
    def evaluate(vars=nil)
        if(vars.nil?) then
            @pk
        else
            @pk_l = @pk["left"].flat_map do |val|
                val == "n"? vars : val
            end
            @pk_r = @pk["right"].flat_map do |val|
                val == "n"? vars : val
            end
            {"left"=> @pk_l, "right"=>@pk_r} 
        
         
        end
        
    end
    
    
end