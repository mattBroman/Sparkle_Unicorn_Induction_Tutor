
require_relative '../../../lib/assets/IHypothesis.rb'

RSpec.describe IHypothesis do
   
    
    context "IHypothesis.initalize" do
        

        it "handles empty JSON" do
            json_ex = {:pk => {:left=>["n", "n","+"], :right=>["2","n","*"]}, :IHypothesis => {:assumptions => {:n => ["k"]}, :assume => {:left=>["k", "k","+"], :right=>["2","k","*"]}}}.to_json
           expect{IHypothesis.new(json_ex)}.to_not raise_error
        end
        

        
        
    end
    
    context "IHypothesis.evaluate" do
       
        it "returns correctly for all variables" do
            json_ex = {:pk => {:left=>["n", "n","+"], :right=>["2","n","*"]}, :IHypothesis => {:assumptions => {:n => ["k"]}, :assume => {:left=>["k", "k","+"], :right=>["2","k","*"]}}}.to_json
            ih = IHypothesis.new(json_ex)
            ih.evaluate.should be true
        end
  
    end
    
    
    
    
    
end