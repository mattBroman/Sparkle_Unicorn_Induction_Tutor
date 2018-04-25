#require_relative "Assumption.rb" 
require_relative "Evaluate.rb" 

class Pk
    
    def initialize(pkl,pkr)
        e = Evaluator.new
        
        lv = e.shunting_yard(pkl.chars)
        rv = e.shunting_yard(pkr.chars)
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