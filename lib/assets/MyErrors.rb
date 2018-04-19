class MissingError < RuntimeError
    
   def initialize(msg="")
       super("Missing: " + msg) 

   end
    
end

class IncorrectError < StandardError
   def initialize(msg="")
      super("Incorrect: " + msg) 
   end
    
end