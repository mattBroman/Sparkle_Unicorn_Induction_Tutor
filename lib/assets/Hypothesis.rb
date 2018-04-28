require "json"
require_relative "Pk.rb"
require_relative "MyErrors.rb"


class Hypothesis
    
   def initialize(args,pk)
       
        @pk = pk
        raise MissingError, "Hypothesis" unless not args=="null" 
        
        @hypothesis = JSON.parse(args)["hypothesis"]
        
        raise MissingError, "Hypothesis" unless not @hypothesis.nil?
        
        @left = @hypothesis["left"]
        
        @right = @hypothesis["right"]

   end
    
    def evaluate

        #sub in k for n on pk
        @pk_k = @pk.evaluate("k")
        
        #check p(k) w/ left and right side
        ret = (@pk_k["left"] == @left and @pk_k["right"] == @right)
        raise IncorrectError, "Hypothesis does not match p(n)" unless ret
        return ret

    end
    
    
end