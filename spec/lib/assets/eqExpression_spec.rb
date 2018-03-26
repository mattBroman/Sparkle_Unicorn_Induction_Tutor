#require 'spec_helper'
require_relative '../../../lib/assets/EqExpression.rb'
RSpec.describe EqExpression do

    context "EqExpression.initalize" do

       
       it "should handle a single chain of equations" do
          assumption = double('Assumption', :evaluate => [{"b" => 2}])
          json_ex = {:equivalenceExpressions => [{:left=>["b", "4", "5", "*","+"], :right=>["b", "20", "+"]}]}.to_json
          
          expect{EqExpression.new(json_ex, assumption)}.to_not raise_error
       end
       
       
       
       it "should handle multiple chains of equations" do
           assumption = double('Assumption', :evaluate => [{"b" => 2}])
          json_ex = {:equivalenceExpressions => [{:left=>["3", "4", "5", "*","+"], :right=>["3", "20", "+"]}, {:left=> [], :right =>["23"]}]}.to_json
          expect{EqExpression.new(json_ex,assumption)}.to_not raise_error
       end
       
       it "should handle malformed json input" do
           assumption = double('Assumption', :evaluate => [{"b" => 2}])
            json_ex = {:equivdfghjgfdExp => [{:left=>["3", "4", "5", "*","+"], :right=>["3", "20", "+"]}]}.to_json 
            expect{EqExpression.new(json_ex, assumption)}.to raise_error(RuntimeError, "Invalid JSON input")
       end
       
       it "should handle missing assumptions" do
           json_ex = {:equivalenceExpressions => [{:left=>["b", "4", "5", "*","+"], :right=>["b", "20", "+"]}]}.to_json
           expect{EqExpression.new(json_ex,{}.to_json)}.to raise_error(RuntimeError, "Missing assumption(s)")
       end
       
        
    end
    
    context "EqExpression.evaluate" do
        it "should return true for a valid chain" do
          assumption = double('Assumption', :evaluate => [{"b" => 2}])
          json_ex = {:equivalenceExpressions => [{:left=>["b", "4", "5", "*","+"], :right=>["b", "20", "+"]}, {:left=> [], :right =>["23"]}]}.to_json 
          e = EqExpression.new(json_ex,assumption)
          e.evaluate.should be true
        end
        
        it "return false for an invalid chain" do
            assumption = double('Assumption', :evaluate => [{"b" => 2}])
            json_ex = {:equivalenceExpressions => [{:left=>["b", "5", "5", "*","+"], :right=>["b", "20", "+"]}, {:left=> [], :right =>["23"]}]}.to_json 
            e = EqExpression.new(json_ex,assumption)
            e.evaluate.should be false
        end
        
        
        
        
    end
    
    
end