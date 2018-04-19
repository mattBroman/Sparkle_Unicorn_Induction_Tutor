require "json"
require_relative "Pk.rb"


class Hypothesis
    
   def initialize(args,pk)
       
        @pk = pk
        
        @hypothesis = JSON.parse(args)["hypothesis"]

        
        @left = @hypothesis["left"]
        
        @right = @hypothesis["right"]

   end
    
    def evaluate

        #sub in k for n on pk
        @pk_k = @pk.evaluate("k")
        
        #check p(k) w/ left and right side
        @pk_k["left"] == @left and @pk_k["right"] == @right
        

    end
    
    
end