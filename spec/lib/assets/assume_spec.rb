#require 'spec_helper'
require 'json'
require_relative '../../../lib/assets/Assume.rb'

RSpec.describe Assume do
   
    
    context "Assume.initalize" do
        

        it "handles valid creation" do
            pk = double('Pk', :evaluate => {"left"=>["n", "n","+"], "right"=>["2","n","*"]})
            assumption = double('Assumption', :evaluate => {"n" => ["k"]})
            json_ex = {:assume => {:left=>["k", "k","+"], :right=>["2","k","*"]}}.to_json
            expect{Assume.new(json_ex,assumption,pk)}.to_not raise_error
        end
        
        it "handles incorrect creation" do
            pk = double('Pk', :evaluate => {"left"=>["n", "n","+"], "right"=>["2","n","*"]})
            assumption = double('Assumption', :evaluate => {"n" => ["k"]})
            json_ex = {:asme => {:left=>["k", "k","*"], :right=>["2","k","*"]}}.to_json
            expect{Assume.new(json_ex,assumption,pk)}.to raise_error(RuntimeError, "Missing assume statement")
        end
        
        
        
    end
    
    context "Assume.evaluate" do
       
        it "returns correctly for valid input" do
            pk = double('Pk', :evaluate => {"left"=>["n", "n","+"], "right"=>["2","n","*"]})
            assumption = double('Assumption', :evaluate => {"n" => ["k"]})
            json_ex = {:assume => {:left=>["k", "k","+"], :right=>["2","k","*"]}}.to_json
            a = Assume.new(json_ex,assumption,pk)
            a.evaluate.should be true

        end
        
        it "returns incorrectly for invalid input" do
            pk = double('Pk', :evaluate => {"left"=>["n", "n","+"], "right"=>["2","n","*"]})
            assumption = double('Assumption', :evaluate => {"n" => ["k"]})
            json_ex = {:assume => {:left=>["k", "k","*"], :right=>["2","k","*"]}}.to_json
            a = Assume.new(json_ex,assumption,pk)
            a.evaluate.should be false

        end
  
    end
    
    
    
    
    
end