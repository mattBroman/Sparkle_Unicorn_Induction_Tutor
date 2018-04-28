require "json"
require_relative "Pk.rb"
require_relative "MyErrors.rb"



class Show
    
   def initialize(args,pk)
       
        @pk = pk
        raise MissingError, "toShow" unless not args=="null" 

        @show = JSON.parse(args)["show"]
        raise MissingError, "toShow" unless not @show.nil?

        
        @left = @show["left"]
        
        @right = @show["right"]

   end
    
    def evaluate

        #sub in k for n on pk
        @pk_k1 = @pk.evaluate(["k","1","+"])
        
        #check p(k) w/ left and right side
        ret = @pk_k1["left"] == @left and @pk_k1["right"] == @right
        raise IncorrectError, "toShow does not match p(k+1)" unless ret
        return ret
        
 
    end
    
    
end