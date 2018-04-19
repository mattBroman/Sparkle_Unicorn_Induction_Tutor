
require_relative '../../../lib/assets/Uih.rb'

RSpec.describe Uih do
   
    
    context "Uih.initalize" do
        

        it "handles empty JSON" do
            pk = double('Pk', :evaluate => {"left"=>["n", "n","+"], "right"=>["2","n","*"]})

            json_ex = {:uih => {:left=>["k", "k","+","2","+"], :right=>["2","k","*","2","+"]}}.to_json
            expect{Uih.new(json_ex,pk)}.to_not raise_error
        end
        

        
        
    end
    
    context "Uih.evaluate" do
       
        it "returns correctly for valid case (1)" do

            pk = Pk.new("n+n","2*n")
            json_ex = {:uih => {:left=>["k", "k","+","2","+"], :right=>["2","k","*","2","+"]}}.to_json
            h= Uih.new(json_ex,pk)
            h.evaluate(["k", "k","+","2","+"]).should be true
        end
        
       
        it "returns correctly for valid case (2)" do

            pk = Pk.new("n+n","2*n")
            json_ex = {:uih => {:left=>["2","k","k","+","+"], :right=>["2","k","*","2","+"]}}.to_json
            h= Uih.new(json_ex,pk)
            h.evaluate(["k", "k","+","2","+"]).should be true
        end
        
        
        it "returns correctly for valid case (2)" do

            pk = Pk.new("n+n","2*n")
            json_ex = {:uih => {:left=>["2","k","k","+","+"], :right=>["2","2","k","*","+"]}}.to_json
            h= Uih.new(json_ex,pk)
            h.evaluate(["k", "k","+","2","+"]).should be true
        end
  
    end
    
    
    
    
    
end