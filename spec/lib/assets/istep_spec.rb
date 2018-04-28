require_relative '../../../lib/assets/Pk.rb'

require_relative '../../../lib/assets/IStep.rb'

RSpec.describe IStep do
   
    
    context "IStep.initalize" do
        

        it "handles empty JSON (1)" do
            #pk = double('Pk', :evaluate => {"left"=>["n", "n","+"], "right"=>["2","n","*"]})
            pk = Pk.new("n+n","2*n")
            json_ex = {:inductiveStep=>{
                :hypothesis => {:left=>["k","k","+"],:right=>["2","k","*"]},
                :show =>{:left=>["k","1","+", "k","1","+","+"], :right=>["2","k","1","+","*"]},
                :pre => [{:left=>["k","1","+", "k","1","+","+"], :right=>["k","k","+","2","+"]}],
                :post => [{:left=>nil, :right=>["2","k","1","+","*"]}],
                :uih => {:left=>nil, :right=>["2","k","*","2","+"]}}}.to_json
        
            expect{IStep.new(json_ex,pk)}.to_not raise_error
            
        end
        it "handles empty JSON (2)" do
            #pk = double('Pk', :evaluate => {"left"=>["n", "n","+"], "right"=>["2","n","*"]})
            pk = Pk.new("n+n","2*n")
            json_ex = {:inductiveStep=>nil}.to_json
        
            expect{IStep.new(json_ex,pk)}.to raise_error MissingError
            
        end       

        
        
    end
    
    context "IStep.evaluate" do
       
        it "returns correctly for all variables" do
            
            
            
            pk = Pk.new("n+n","2*n")
            json_ex = {:inductiveStep=>{
                :hypothesis => {:left=>["k","k","+"],:right=>["2","k","*"]},
                :show =>{:left=>["k","1","+", "k","1","+","+"], :right=>["2","k","1","+","*"]},
                :pre => [{:left=>["k","1","+", "k","1","+","+"], :right=>["k","k","+","2","+"]}],
                :post => [{:left=>nil, :right=>["2","k","1","+","*"]}],
                :uih => {:left=>nil, :right=>["2","k","*","2","+"]}}}.to_json
                    
            is = IStep.new(json_ex,pk)
            

            is.evaluate.should be true
        end
        
        it "returns correctly for all variables (2)" do
            
            
            
            pk = Pk.new("n+n","2*n")
            json_ex = {:inductiveStep=>{
                :hypothesis => {:left=>["k","k","+"],:right=>["2","k","*"]},
                :show =>{:left=>["k","1","+", "k","1","+","+"], :right=>["2","k","1","+","*"]},
                :pre => [{:left=>["k","1","+", "k","1","+","+"], :right=>["k","k","+","2","+"]}],
                :post => [{:left=>nil, :right=>["2","k","1","+","*"]}],
                :uih => {:left=>["k","k","+","2","+"], :right=>["2","k","*","2","+"]}}}.to_json
                    
            is = IStep.new(json_ex,pk)
            

            is.evaluate.should be true
        end
        
        it "returns correctly for all variables (2)" do
            
            
            
            pk = Pk.new("n+n+n","3*n")
            json_ex = {:inductiveStep=>{
                :hypothesis => {:left=>["k","k","+","k","+"],:right=>["3","k","*"]},
                :show =>{:left=>["k","1","+","k","1","+","+", "k","1","+","+"], :right=>["3","k","1","+","*"]},
                :pre => [{:left=>["k","1","+", "k","1","+","+","k","1","+","+"], :right=>["k","k","+","k","+","3","+"]}],
                :post => [{:left=>nil, :right=>["3","k","1","+","*"]}],
                :uih => {:left=>nil, :right=>["3","k","*","3","+"]}}}.to_json
                    
            is = IStep.new(json_ex,pk)
            

            is.evaluate.should be true
        end
                
  
    end
    
    
    
    
    
end