require "json"

class Assumption
   
   def initialize(args)
        
        #non empty assumption
        @assumptions = JSON.parse(args)["assumptions"]
        raise RuntimeError, "Invalid Assumption request" unless not @assumptions.nil?
        raise RuntimeError, "No Assumption(s) provided" unless not @assumptions.empty?


        #invalid variable names
        @assumptions.each do |key,val|
            
            raise RuntimeError, "Invalid Assumption variable(s)" unless (key.to_s.match(/^[A-Za-z]$/) && key.to_s.length == 1)
            
        end
        
      

   end
   
   
   def evaluate
      
      #map of assumptions
      @assumptions
       
   end
    
    
    
end