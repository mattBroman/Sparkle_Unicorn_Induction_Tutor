
require_relative '../../../lib/assets/Proof.rb'

RSpec.describe Proof do
   
    
    context "Proof.initalize" do
        

        it "handles empty JSON" do
            
            json_ex = {:pk => {:left=>["n", "n","+"], :right=>["2","n","*"]}, :proof=>{:assumptions => {:n=>["k","1","+"]}, :equivalenceExpressions => [{:left=>["k","1","+","k","1","+","+"], :right=>["2","k","1","+","*"]}]}}.to_json
        
            expect{Proof.new(json_ex)}.to_not raise_error
            
        end
        

        
        
    end
    
    context "Proof.evaluate" do
       
        it "returns correctly for all variables" do
            json_ex = {:pk => {:left=>["n", "n","+"], :right=>["2","n","*"]}, :proof=>{:assumptions => {:n=>["k","1","+"]}, :equivalenceExpressions => [{:left=>["k","1","+","k","1","+","+"], :right=>["2","k","1","+","*"]}]}}.to_json
            p = Proof.new(json_ex)
            p.evaluate.should be true
        end
        
        it "returns correctly for all variables" do
            json_ex = {:pk => {:left=>["n", "n","+"], :right=>["2","n","*"]}, :proof=>{:assumptions => {:n=>["k","1","+"]}, :equivalenceExpressions => [{:left=>["k","1","+","k","1","+","+"], :right=>["2","k","*"]}]}}.to_json
            p = Proof.new(json_ex)
            p.evaluate.should be false
        end
                
  
    end
    
    
    
    
    
end