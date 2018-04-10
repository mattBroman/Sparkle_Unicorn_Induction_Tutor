#require 'spec_helper'
require_relative '../../../lib/assets/EqExpression.rb'
RSpec.describe EqExpression do

    context "EqExpression.initalize" do

       
       it "should handle a single chain of equations" do
          assumption = double('Assumption', :evaluate => {"b" => ["2"]})
          json_ex = {:equivalenceExpressions => [{:left=>["b", "b","+"], :right=>["4"]}]}.to_json
          
          expect{EqExpression.new(json_ex, assumption)}.to_not raise_error
       end
       

       
       
       
       it "should handle multiple chains of equations" do
           assumption = double('Assumption', :evaluate => {"b" => ["2"]})
          json_ex = {:equivalenceExpressions => [{:left=>["3", "4", "5", "*","+"], :right=>["3", "20", "+"]}, {:left=> [], :right =>["23"]}]}.to_json
          expect{EqExpression.new(json_ex,assumption)}.to_not raise_error
       end
       
       it "should handle malformed json input" do
           assumption = double('Assumption', :evaluate => {"b" => ["2"]})
            json_ex = {:equivdfghjgfdExp => [{:left=>["3", "4", "5" ,"*","+"], :right=>["3", "20", "+"]}]}.to_json 
            expect{EqExpression.new(json_ex, assumption)}.to raise_error(RuntimeError, "Missing expression(s)")
       end
       
       it "should handle no assumptions" do
           assumption = double('Assumption', :evaluate => {})
           json_ex = {:equivalenceExpressions => [{:left=>["b", "4", "5", "*","+"], :right=>["b", "20", "+"]}]}.to_json
           expect{EqExpression.new(json_ex,assumption)}.to raise_error(RuntimeError, "Missing assumption(s)")
       end
       
       
       
       it "should handle missing assumptions" do
           assumption = double('Assumption', :evaluate => {"c" => ["2"]})
           json_ex = {:equivalenceExpressions => [{:left=>["b", "4", "5", "*","+"], :right=>["b", "20", "+"]}]}.to_json
           expect{EqExpression.new(json_ex,assumption)}.to raise_error(RuntimeError, "Missing assumption(s)")
       end
       
        
       it "should handle a single chain of symbolic equations" do
          pk = double('Pk', :evaluate => {"left"=>["n", "n","+"], "right"=>["2","n","*"]})

          assumption = double('Assumption', :evaluate => {"n" => ["k","1","+"]})
          json_ex = {:equivalenceExpressions => [{:left=>["k","1","+","k","1","+","+"], :right=>["2","k","1","+","*"]}]}.to_json
          
          expect{EqExpression.new(json_ex, assumption,true,pk)}.to_not raise_error
       end
        
        
    end
    
    context "EqExpression.evaluate" do
        it "should return true for a valid chain" do
          assumption = double('Assumption', :evaluate => {"b" => ["3"]})
          json_ex = {:equivalenceExpressions => [{:left=>["b", "4", "5", "*","+"], :right=>["b", "20", "+"]}, {:left=> nil, :right =>["23"]}]}.to_json 
          e = EqExpression.new(json_ex,assumption)
          e.evaluate.should be true
        end
        
        it "return false for an invalid chain" do
            assumption = double('Assumption', :evaluate => {"b" => ["2"]})
            json_ex = {:equivalenceExpressions => [{:left=>["b", "5", "5", "*","+"], :right=>["b", "20", "+"]}, {:left=> nil, :right =>["23"]}]}.to_json 
            e = EqExpression.new(json_ex,assumption)
            e.evaluate.should be false
        end
        

        
        
        
        
    end
    
    
    context "EqExpression.sym_evaluate" do
        
       it "should return true for a valid symbolic chain" do
          pk = double('Pk', :evaluate => {"left"=>["n", "n","+"], "right"=>["2","n","*"]})

          assumption = double('Assumption', :evaluate => {"n" => ["k","1","+"]})
          json_ex = {:equivalenceExpressions => [{:left=>["k","1","+","k","1","+","+"], :right=>["2","k","1","+","*"]}]}.to_json
          e = EqExpression.new(json_ex,assumption,true,pk)

          e.evaluate.should be true
       end  
       
       it "should return true for a valid symbolic chain (longer)" do
          pk = double('Pk', :evaluate => {"left"=>["n", "n","+"], "right"=>["2","n","*"]})

          assumption = double('Assumption', :evaluate => {"n" => ["k","1","+"]})
          json_ex = {:equivalenceExpressions => [{:left=>["k","1","+","k","1","+","+"], :right=>["2","k","*","2","+"]},{:left=>[],:right=>["2","k","1","+","*"]}]}.to_json
          e = EqExpression.new(json_ex,assumption,true,pk)

          e.evaluate.should be true
       end  
       
       it "should return false for an invalid symbolic chain" do
          pk = double('Pk', :evaluate => {"left"=>["n", "n","+"], "right"=>["2","n","*"]})

          assumption = double('Assumption', :evaluate => {"n" => ["k","1","+"]})
          json_ex = {:equivalenceExpressions => [{:left=>["k","1","+","k","1","+","+"], :right=>["2","k","*"]}]}.to_json
          e = EqExpression.new(json_ex,assumption,true,pk)

          e.evaluate.should be false
       end           
        
    end
    
    

    
    
end