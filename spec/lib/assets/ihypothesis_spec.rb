
require_relative '../../../lib/assets/IHypothesis.rb'

RSpec.describe IHypothesis do
   
    
    context "IHypothesis.initalize" do
        

        it "handles empty JSON" do
            pk = double('Pk', :evaluate => {"left"=>["n", "n","+"], "right"=>["2","n","*"]})

            json_ex = {:IHypothesis => {:assumptions => {:n => ["k"]}, :assume => {:left=>["k", "k","+"], :right=>["2","k","*"]}}}.to_json
           expect{IHypothesis.new(json_ex,pk)}.to_not raise_error
        end
        

        
        
    end
    
    context "IHypothesis.evaluate" do
       
        it "returns correctly for all variables" do
            pk = double('Pk', :evaluate => {"left"=>["n", "n","+"], "right"=>["2","n","*"]})

            json_ex = {:IHypothesis => {:assumptions => {:n => ["k"]}, :assume => {:left=>["k", "k","+"], :right=>["2","k","*"]}}}.to_json
            ih = IHypothesis.new(json_ex,pk)
            ih.evaluate.should be true
        end
  
    end
    
    
    
    
    
end