
require_relative '../../../lib/assets/Grader.rb'

RSpec.describe Grader do
    context "Grader.initialize" do
        
        
        it "should accept a good proof" do
            #pk = double('Pk', :evaluate => {"left"=>["n", "n","+"], "right"=>["2","n","*"]})
            pk = Pk.new("n+n","2*n")
           # json_ex = {:baseCase => {:assumptions => {:b=>["4"]}, :equivalenceExpressions => [{:left=>["b", "4", "5", "*","+"], :right=>["b", "20", "+"]}]}}.to_json
            
            json_ex = {:baseCase => {:assumptions => {:b=>["4"]}, :equivalenceExpressions => [{:left=>["b", "4", "5", "*","+"], :right=>["b", "20", "+"]}]},
                :inductiveStep=>{
                :hypothesis => {:left=>["k","k","+","k","+"],:right=>["3","k","*"]},
                :show =>{:left=>["k","1","+","k","1","+","+", "k","1","+","+"], :right=>["3","k","1","+","*"]},
                :pre => [{:left=>["k","1","+", "k","1","+","+","k","1","+","+"], :right=>["k","k","+","k","+","3","+"]}],
                :post => [{:left=>nil, :right=>["3","k","1","+","*"]}],
                :uih => {:left=>nil, :right=>["3","k","*","3","+"]}}}.to_json
            expect{Grader.new(json_ex,pk)}.to_not raise_error 
        end
        
        

        
    end
    
    context "Grader.evaluate" do
        
        it "should evaluate an incorrect proof corectly" do
             pk = Pk.new("n+n","2*n")
           # json_ex = {:baseCase => {:assumptions => {:b=>["4"]}, :equivalenceExpressions => [{:left=>["b", "4", "5", "*","+"], :right=>["b", "20", "+"]}]}}.to_json
            
            json_ex = {:baseCase => {:assumptions => {:b=>["4"]}, :equivalenceExpressions => [{:left=>["b", "4", "5", "*","+"], :right=>["b", "20", "+"]}]},
                :inductiveStep=>{
                :hypothesis => {:left=>["k","k","+","k","+"],:right=>["3","k","*"]},
                :show =>{:left=>["k","1","+","k","1","+","+", "k","1","+","+"], :right=>["3","k","1","+","*"]},
                :pre => [{:left=>["k","1","+", "k","1","+","+","k","1","+","+"], :right=>["k","k","+","k","+","3","+"]}],
                :post => [{:left=>nil, :right=>["3","k","1","+","*"]}],
                :uih => {:left=>nil, :right=>["3","k","*","3","+"]}}}.to_json

            g = Grader.new(json_ex,pk)
            g.evaluate.should eq({:baseCase => false ,:ihypothesis=>false})
        end
        
        
        it "should evaluate a valid proof corectly" do
            pk = Pk.new("n+n","2*n")
            
            json_ex = {:baseCase => {:assumptions => {:b=>["1"]}, :equivalenceExpressions => [{:left=>["1", "1","+"], :right=>["2"]}]},
                :inductiveStep=>{
                :hypothesis => {:left=>["k","k","+"],:right=>["2","k","*"]},
                :show =>{:left=>["k","1","+", "k","1","+","+"], :right=>["2","k","1","+","*"]},
                :pre => [{:left=>["k","1","+", "k","1","+","+"], :right=>["k","k","+","2","+"]}],
                :post => [{:left=>nil, :right=>["2","k","1","+","*"]}],
                :uih => {:left=>["k","k","+","2","+"], :right=>["2","k","*","2","+"]}}}.to_json

            g = Grader.new(json_ex,pk)
            g.evaluate.should eq({:baseCase => true ,:ihypothesis=>true})
        end
        
        it "should evaluate an invalid proof corectly" do
            pk = Pk.new("n+n","2*n")
            
            json_ex = {:baseCase => {:assumptions => {:b=>["2"]}, :equivalenceExpressions => [{:left=>["1", "1","+"], :right=>["2"]}]},
                :inductiveStep=>{
                :hypothesis => {:left=>["k","k","+"],:right=>["2","k","*"]},
                :show =>{:left=>["k","1","+", "k","1","+","+"], :right=>["2","k","1","+","*"]},
                :pre => [{:left=>["k","1","+", "k","1","+","+"], :right=>["k","k","+","2","+"]}],
                :post => [{:left=>nil, :right=>["2","k","1","+","*"]}],
                :uih => {:left=>["k","k","+","2","+"], :right=>["2","k","*","2","+"]}}}.to_json

            g = Grader.new(json_ex,pk)
            g.evaluate.should eq({:baseCase => false ,:ihypothesis=>true})
        end

        

        
    end
    
end