
require_relative '../../../lib/assets/Grader.rb'

RSpec.describe Grader do
    context "Grader.initialize" do
        
        
        it "should accept a good proof" do
            pk = double('Pk', :evaluate => {"left"=>["n", "n","+"], "right"=>["2","n","*"]})

            json_ex = {:baseCase => {:assumptions => {:b=>["4"]}, :equivalenceExpressions => [{:left=>["b", "4", "5", "*","+"], :right=>["b", "20", "+"]}]}}.to_json
            expect{Grader.new(json_ex,pk)}.to_not raise_error 
        end
        
        
        it "should accept an invalid proof" do
            pk = double('Pk', :evaluate => {"left"=>["n", "n","+"], "right"=>["2","n","*"]})

            json_ex = {:baseCase => {:assumptions => {:b=>["3"]}, :equivalenceExpressions => [{:left=>["b", "5", "5", "*","+"], :right=>["b", "20", "+"]}]}}.to_json
            expect{Grader.new(json_ex,pk)}.to_not raise_error 
        end
        
    end
    
    context "Grader.evaluate" do
        
        it "should evaluate a valid proof corectly" do
            pk = double('Pk', :evaluate => {"left"=>["n", "n","+"], "right"=>["2","n","*"]})


            json_ex = {
                :baseCase => {:assumptions => {:b=>["3"]}, 
                    :equivalenceExpressions => [{:left=>["b", "4", "5", "*","+"], :right=>["b", "20", "+"]}]},
                :IHypothesis => {:assumptions => {:n => ["k"]},
                    :assume => {:left=>["k", "k","+"], :right=>["2","k","*"]}}
                
            }.to_json

            g = Grader.new(json_ex,pk)
            g.evaluate.should eq({:baseCase => true ,:ihypothesis=>true})
        end
        
        

        

        

        
    end
    
end