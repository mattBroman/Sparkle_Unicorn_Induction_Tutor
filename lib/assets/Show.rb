require "json"
require_relative "Pk.rb"


class Show
    
   def initialize(args,pk)
       
        @pk = pk
        
        @show = JSON.parse(args)["show"]

        
        @left = @show["left"]
        
        @right = @show["right"]

   end
    
    def evaluate

        #sub in k for n on pk
        @pk_k1 = @pk.evaluate(["k","1","+"])
        
        #check p(k) w/ left and right side
        @pk_k1["left"] == @left and @pk_k1["right"] == @right
        

    end
    
    
end