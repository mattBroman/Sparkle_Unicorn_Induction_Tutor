
require_relative '../../../lib/assets/Hypothesis.rb'

RSpec.describe Hypothesis do
   
    
    context "Hypothesis.initalize" do
        

        it "handles empty JSON" do
            pk = double('Pk', :evaluate => {"left"=>["n", "n","+"], "right"=>["2","n","*"]})

            json_ex = {:hypothesis => {:left=>["k", "k","+"], :right=>["2","k","*"]}}.to_json
            expect{Hypothesis.new(json_ex,pk)}.to_not raise_error
        end
        

        
        
    end
    
    context "Hypothesis.evaluate" do
       
        it "returns correctly for all variables" do
            #pk = double('Pk', :evaluate => {"left"=>["n", "n","+"], "right"=>["2","n","*"]}, :evaluate.with("k") => {"left"=>["n", "n","+"], "right"=>["2","n","*"]})
            #allow(Pk).to receive(:evaluate).with("k").and_return({"left"=>["n", "n","+"], "right"=>["2","n","*"]})
           
            pk = Pk.new("n+n","2*n")
            json_ex = {:hypothesis => {:left=>["k", "k","+"], :right=>["2","k","*"]}}.to_json
            h= Hypothesis.new(json_ex,pk)
            h.evaluate.should be true
        end
  
    end
    
    
    
    
    
end