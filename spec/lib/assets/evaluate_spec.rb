#require 'spec_helper'
require_relative '../../../lib/assets/Evaluate.rb'
require_relative '../../../lib/assets/MyErrors.rb'


RSpec.describe Evaluator do
    e = Evaluator.new
    
    context 'Evaluator.shunting_yard' do
        it 'successfully returns postfix array' do
            arg = ['2', '+', '2']
            postfix = e.shunting_yard(arg)
            expect(postfix).to eq ['2','2','+']
        end
        it 'handles order of operations' do 
            arg = ['2' , '+', '2', '*', '5']
            postfix = e.shunting_yard(arg)
            expect(postfix).to eq ['2', '2', '5', '*', '+']
            
            arg = ['4' , '^', '2', '+' ,'5' ,'/' ,'3' ,'-' ,'2' ,'*' ,'4']
            postfix = e.shunting_yard(arg)
            expect(postfix).to eq ['4', '2', '^', '5', '3', '/', '+', '2', '4', '*', '-']
        end
        it 'handles parentheses' do
            arg  = ['(', '2', '+', '1', ')', '*', '(', '3', '-', '4', ')']
            postfix = e.shunting_yard(arg)
            expect(postfix).to eq ['2', '1', '+', '3', '4', '-', '*']
            
            arg = ['(', '(', '4', '-', '6', ')', '^', '(', '8', '*', '2', '-', '(', '1', '+', '8', ')', '/', '3', '-', '4', '*', '(', '8', '+', '1', ')', '/', '(', '8', '*', '(', '8', '*', '(', '1', '+', '1', ')', ')', ')', ')', ')']
            postfix = e.shunting_yard(arg)
            expect(postfix).to eq ['4', '6', '-', '8', '2', '*', '1', '8', '+', '3', '/', '-', '4', '8', '1', '+', '*', '8', '8', '1', '1', '+', '*', '*', '/', '-', '^']
        end
        it 'handles varibles' do
            arg = ['n', '+', 'n']
            postfix = e.shunting_yard(arg)
            expect(postfix).to eq ['n', 'n', '+']
        end
        it 'throws on mismatched parentheses' do
            arg = ['(', '2', '+', '2']
            expect{e.shunting_yard(arg)}.to raise_error(IncorrectError)
            
            arg = ['2', '+', '2', ')']
            expect{e.shunting_yard(arg)}.to raise_error(IncorrectError)
       end
       
       it "handles summations" do
          arg = ["\\","sum","_","{","i","=","0","}","^","{","k","}","{","i","}"] 
          expect e.shunting_yard(arg).should == ['sum','i','0','|','k','|','i','|']
           
           
       end
       
       
       it "tokenizes" do
            arg = "\\sum_{i=0}^{k}{i}" 


           e.tokenize(arg).should == ["\\","sum","_","{","i","=","0","}","^","{","k","}","{","i","}"] 
           
       end
       
    end
    
    
    
    context 'postfix solver' do
        it 'correctly solves equations' do
            expect(e.solve(['4', '2', '+'])).to eq 6
            expect(e.solve(['4', '2', '-'])).to eq 2
            expect(e.solve(['4', '2', '*'])).to eq 8
            expect(e.solve(['4', '2', '/'])).to eq 2
            
            arg = ['4', '2', '^', '5', '3', '/', '+', '2', '4', '*', '-']
            val = (29.0/3.0 - e.solve(arg)).abs
            expect(val).to be < 0.0000000000001 
            
            arg = ['2', '1', '+', '3', '4', '-', '*']
            expect(e.solve(arg)).to eq -3
        end
        
        it 'fails on wrong number of operator inputs' do
            expect{e.solve(['2', '+'])}.to raise_error
        end
        
        it 'fails on varibles' do 
            expect{e.solve(['n', '+', 'n'])}.to raise_error
        end
        
        it 'fails on missing variables' do
           arg = ['b','1','+'] 
            expect{e.solve(arg)}.to raise_error MissingError
        end
        
            
    end
    
    
    context 'symbolic eval' do
        it "compares simple expressions (1)" do
            eq1 = ['k','k','+']
            eq2 = ['2','k','*']
            e.sym_eq_equal(eq1,eq2).should be true 
        end
        
        it "compares simple expressions (2)" do
            eq1 = ['k','k','+']
            eq2 = ['2','k','+']
            e.sym_eq_equal(eq1,eq2).should be false 
        end
        
        it "compares summation expressions (1)" do
            eq1 = ["sum","i","k","4","-","|","k","1","+","|","2","i","*","2","+","|"]
            eq2 = ["sum","i","k","4","-","|","k","|","2","i","*","2","+","|","2","k","*","+","4","+"]
            e.sym_eq_equal(eq1,eq2).should be true 
        end
        
        it "compares summation expressions (2)" do
            eq1 = ["sum","i","k","4","-","|","k","1","+","|","2","i","*","2","+","|"]
            eq2 = ["sum","i","k","4","-","|","k","|","2","i","*","2","+","|","2","k","+","+","2","+"]
            e.sym_eq_equal(eq1,eq2).should be false
        end
        
        
    end
    
    context "summation given params" do
       it "summates correctly (1)" do
          lower = {:var => 'i', :value => 0}
          upper = 4
          eq = ['2','i','*']
          e.summation(lower,upper,eq).should be 20.0
           
       end
        
    end
    
    context "solve summation" do
        it "solves summation expressions (1)" do
            eq1 = ["sum","i","0","|","4","|","i","|"]
            e.solve(eq1).should be 10.0
        end
        
        it "solves summation expressions (2)" do
            eq1 = ["sum","i","4","4","-","|","4","1","+","|","2","i","*","2","+","|"]
            e.solve(eq1).should be 42.0
        end   
        
        it "solves nested summation expressions (1)" do
            eq1 = ["sum","i","0","|","4","|","sum","j","0","|","2","|","i","j","*","|","|"]
            e.solve(eq1).should be 30.0
        end        
        it "solves nested summation expressions (2)" do
            eq1 = ["sum","i","0","|","4","|","sum","j","0","|","i","|","i","j","*","|","|"]
            e.solve(eq1).should be 65.0
        end
        it "solves nested summation expressions (3)" do
            eq1 = ["sum","i","0","|","4","|","sum","j","i","|","i","|","i","j","*","|","|"]
            e.solve(eq1).should be 30.0
        end 
    end
    context "solve product" do
        it "solves product expressions (1)" do
            eq1 = ["prod","i","1","|","4","|","i","|"]
            e.solve(eq1).should be 24.0
        end
                    
    end    
    
end