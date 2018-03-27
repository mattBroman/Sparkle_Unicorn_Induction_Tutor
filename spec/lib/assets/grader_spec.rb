
require_relative '../../../lib/assets/Grader.rb'

RSpec.describe Grader do
    context "Grader.initialize" do
        
        
        it "should accept a good proof" do
            json_ex = {:baseCase => {:assumptions => [{:b=>3}], :equivalenceExpressions => [{:left=>["b", "4", "5", "*","+"], :right=>["b", "20", "+"]}]}}.to_json
            expect{Grader.new(json_ex)}.to_not raise_error 
        end
        
        
        it "should accept an invalid proof" do
            json_ex = {:baseCase => {:assumptions => [{:b=>3}], :equivalenceExpressions => [{:left=>["b", "5", "5", "*","+"], :right=>["b", "20", "+"]}]}}.to_json
            expect{Grader.new(json_ex)}.to_not raise_error 
        end
        
    end
    
    context "Grader.evaluate" do
        
        it "should evaluate a valid baseCase corectly" do
            json_ex = {:baseCase => {:assumptions => [{:b=>3}], :equivalenceExpressions => [{:left=>["b", "4", "5", "*","+"], :right=>["b", "20", "+"]}]}}.to_json
            g = Grader.new(json_ex)
            g.evaluate.should eq({:baseCase => true})
        end
        
        
        it "should evaluate an invalid baseCase as false" do
            json_ex = {:baseCase => {:assumptions => [{:b=>3}], :equivalenceExpressions => [{:left=>["b", "5", "5", "*","+"], :right=>["b", "20", "+"]}]}}.to_json
            g = Grader.new(json_ex)
            g.evaluate.should eq({:baseCase => false})
        end
        
        it "should raise an error for missing argument(s)" do
            json_ex = {:baseCase => {:assumptions => [{:c=>3}], :equivalenceExpressions => [{:left=>["b", "4", "5", "*","+"], :right=>["b", "20", "+"]}]}}.to_json
            g = Grader.new(json_ex)
            g.evaluate.should eq({:baseCase => "Missing assumption(s)"})
        end
        
        it "should raise an error for missing arguments for baseCase" do
            json_ex = {:baseCase => {:assumptions => [{:b=>3}], :equivalenceExns => [{:left=>["b", "4", "5", "*","+"], :right=>["b", "20", "+"]}]}}.to_json
            g = Grader.new(json_ex)
            g.evaluate.should eq({:baseCase => "Invalid EqExpression request"})
        end
        
    end
    
end