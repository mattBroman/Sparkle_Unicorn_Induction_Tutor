require_relative "Assumption.rb" 
require_relative "Pk.rb" 


class Assume
    
   def initialize(args,assumptions,pk)
       
        @pk = pk.evaluate
        

        raise RuntimeError, "Missing p(k)" unless not @pk.nil?
       
        @assumptions = assumptions
       
        raise RuntimeError, "Missing assumption(s)" unless not @assumptions.nil?
        
        @lr_line = JSON.parse(args)["assume"]
        
        raise RuntimeError, "Missing assume statement" unless not @lr_line.nil?


        raise RuntimeError, "Missing left statement" unless not @lr_line["left"].nil?
        raise RuntimeError, "Missing right statement" unless not @lr_line["right"].nil?
   
 end
    
    def evaluate
        
        #check assumptions for one variable and n=k
        
        
        #sub in k for n for pk
    
        @assumptions.evaluate.each do |key,val|
            @pk["left"].map! { |x|
                x==key.to_s ? val[0] : x
            }
            @pk["right"].map! { |x|
                x==key.to_s ? val[0] : x
            }
        end
        

        @pk = JSON.parse(@pk.to_json)
        
        @pk == @lr_line


       
        
    end
    
    
end