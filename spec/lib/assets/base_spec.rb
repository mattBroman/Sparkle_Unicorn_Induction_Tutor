#require 'spec_helper'
require_relative '../../../lib/assets/Base.rb'
require "json"
RSpec.describe BaseCase do
    context "BaseCase.initialize" do
        
        it "should accept valid json for assumptions and eqEquations" do
            json_ex = {:baseCase => {:assumptions => {:b=>["3"]}, :equivalenceExpressions => [{:left=>["b", "4", "5", "*","+"], :right=>["b", "20", "+"]}]}}.to_json
            expect{BaseCase.new(json_ex)}.to_not raise_error
            
        end
        
        it "should reject invalid JSON" do
            json_ex = {:baadfadfaase => {:assumptions => {:b=>["3"]}, :equivalenceExpressions => [{:left=>["b", "4", "5", "*","+"], :right=>["b", "20", "+"]}]}}.to_json
            expect{BaseCase.new(json_ex)}.to raise_error(RuntimeError, "Invalid baseCase request")
            
        end
        
        
        
        
    end
    
    
    context "Base.evaluate" do
    
        it "should return true for valid baseCase" do
            json_ex = {:baseCase => {:assumptions => {:b=>["3"]}, :equivalenceExpressions => [{:left=>["b", "4", "5", "*","+"], :right=>["b", "20", "+"]}]}}.to_json
            b = BaseCase.new(json_ex)
            b.evaluate.should be true
        end
        
        it "should return false for invalid baseCase" do
            json_ex = {:baseCase => {:assumptions => {:b=>["3"]}, :equivalenceExpressions => [{:left=>["b", "5", "5", "*","+"], :right=>["b", "20", "+"]}]}}.to_json
            b = BaseCase.new(json_ex)
            b.evaluate.should_not be true
        end
    
    
    end
    
    
end