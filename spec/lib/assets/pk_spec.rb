
require_relative '../../../lib/assets/Pk.rb'

RSpec.describe Pk do
    context "Pk.initialize" do
        
        it "should accept a valid input" do
            lv = "n+n"
            rv = "2*n"
            expect{Pk.new(lv,rv)}.to_not raise_error
        end
        
    end
    
    context "Pk.evaluate" do
        
        
        it "should evaluate a valid input" do
            lv = "n+n"
            
            rv = "2*n"
            
            pk = Pk.new(lv,rv)
            pk.evaluate.should be == {"left"=>["n","n","+"],"right"=>["2","n","*"]}
        end
        

        

        

        
    end
    
end