require "json"
require_relative "MyErrors.rb"

class Assumption
   
   def initialize(args)
        
        #non empty assumption
        @assumptions = JSON.parse(args)["assumptions"]
        raise MissingError, "No Assumption(s) provided" unless not @assumptions.nil?


        #invalid variable names
        @assumptions.each do |key,val|
            
            raise IncorrectError, "Invalid Assumption variable(s) '#{key}'" unless (key.to_s.match(/^[A-Za-z]$/) && key.to_s.length == 1)
            
        end
        
      

   end
   
   
   def evaluate
      
      #map of assumptions
      @assumptions
       
   end
    
    
    
end