
require_relative '../../../lib/assets/Show.rb'

RSpec.describe Show do
   
    
    context "Show.initalize" do
        

        it "handles empty JSON" do
            pk = double('Pk', :evaluate => {"left"=>["n", "n","+"], "right"=>["2","n","*"]})

            json_ex = {:show => {:left=>["k","1","+", "k","1","+","+"], :right=>["2","k","1","+","*"]}}.to_json
            expect{Show.new(json_ex,pk)}.to_not raise_error
        end
        

        
        
    end
    
    context "Show.evaluate" do
       
        it "returns correctly for all variables" do
            #pk = double('Pk', :evaluate => {"left"=>["n", "n","+"], "right"=>["2","n","*"]}, :evaluate.with("k") => {"left"=>["n", "n","+"], "right"=>["2","n","*"]})
            #allow(Pk).to receive(:evaluate).with("k").and_return({"left"=>["n", "n","+"], "right"=>["2","n","*"]})
           
            pk = Pk.new("n+n","2*n")
            json_ex = {:show => {:left=>["k","1","+", "k","1","+","+"], :right=>["2","k","1","+","*"]}}.to_json
            s= Show.new(json_ex,pk)
            s.evaluate.should be true
        end
  
        it "returns false for inncorect" do
            #pk = double('Pk', :evaluate => {"left"=>["n", "n","+"], "right"=>["2","n","*"]}, :evaluate.with("k") => {"left"=>["n", "n","+"], "right"=>["2","n","*"]})
            #allow(Pk).to receive(:evaluate).with("k").and_return({"left"=>["n", "n","+"], "right"=>["2","n","*"]})
           
            pk = Pk.new("n+n","2*n")
            json_ex = {:show => {:left=>["k","k","+","+"], :right=>["3","k","1","+","*"]}}.to_json
            s= Show.new(json_ex,pk)
            expect{s.evaluate}.to raise_error(IncorrectError) 
        end
  
  
  
    end
    
    
    
    
    
end