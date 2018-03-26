require "json"

class Assumption
   
   def initialize(args)
        
        #non empty assumption
        @assumptions = JSON.parse(args)["assumptions"]
        raise RuntimeError, "Invalid JSON request" unless not @assumptions.nil?
        raise RuntimeError, "No base cases provided" unless not @assumptions.empty?


        #invalid variable names
        @assumptions.each do |elem|
            elem.each do |key,value|
                raise RuntimeError, "Invalid base variable" unless (key.to_s.match(/^[A-Za-z]$/) && key.to_s.length == 1)
            end
        end
        
        puts @assumptions

   end
   
   
   def evaluate
      
      @assumptions
       
   end
    
    
    
end