
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
            g.evaluate.should eq({
                :correct=>false,
                :baseCase => {
                    :result=>false,
                    :error=>"Incorrect: p(b) differs from work"
                },
                :inductiveStep=>{
                    :result=>true,
                    :error=>nil,
                    :hypothesis=>{
                        :result=>true,
                        :error=>nil
                    },
                    :toShow=>{
                        :result=>true,
                        :error=>nil
                    }
                }
            })
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
            g.evaluate.should eq({
                :correct=>true,
                :baseCase => {
                    :result=>true,
                    :error=>nil
                },
                :inductiveStep=>{
                    :result=>true,
                    :error=>nil,
                    :hypothesis=>{
                        :result=>true,
                        :error=>nil
                    },
                    :toShow=>{
                        :result=>true,
                        :error=>nil
                    }
                }
            })
        end
        
        
        it "should evaluate a base case even when the others elements are missing" do
            pk = Pk.new("n+n","2*n")
            
            json_ex = {:baseCase => {:assumptions => {:b=>["1"]}, :equivalenceExpressions => [{:left=>["1", "1","+"], :right=>["2"]}]},
                :inductiveStep=>{
                :hypothesis => nil,
                :show => nil,
                :pre => [],
                :post => [],
                :uih => nil}}.to_json

            g = Grader.new(json_ex,pk)
            g.evaluate.should include({
                :correct=>false,
                :baseCase => {
                    :result=>true,
                    :error=>nil
                }
            })
        end
        
        it "should evaluate an inductive step without a base case corectly" do
            pk = Pk.new("n+n","2*n")
            
            json_ex = {:baseCase => nil,
                :inductiveStep=>{
                :hypothesis => {:left=>["k","k","+"],:right=>["2","k","*"]},
                :show =>{:left=>["k","1","+", "k","1","+","+"], :right=>["2","k","1","+","*"]},
                :pre => [{:left=>["k","1","+", "k","1","+","+"], :right=>["k","k","+","2","+"]}],
                :post => [{:left=>nil, :right=>["2","k","1","+","*"]}],
                :uih => {:left=>["k","k","+","2","+"], :right=>["2","k","*","2","+"]}}}.to_json

            g = Grader.new(json_ex,pk)
            g.evaluate.should include({
                :correct=>false,
                :inductiveStep=>{
                    :result=>true,
                    :error=>nil,
                    :hypothesis=>{
                        :result=>true,
                        :error=>nil
                    },
                    :toShow=>{
                        :result=>true,
                        :error=>nil
                    }
                }
            })
        end        
        
        it "should evaluate an inductive hypothesis without other elements" do
            pk = Pk.new("n+n","2*n")
            
            json_ex = {:baseCase => nil,
                :inductiveStep=>{
                :hypothesis => {:left=>["k","k","+"],:right=>["2","k","*"]},
                :show =>nil,
                :pre => [],
                :post => [],
                :uih => nil}}.to_json

            g = Grader.new(json_ex,pk)
            g.evaluate.should include({
                :correct=>false,
                :inductiveStep=>{
                    :result=>false,
                    :error=>"Missing: Use of IH",
                    :hypothesis=>{
                        :result=>true,
                        :error=>nil
                    },
                    :toShow=>{
                        :result=>false,
                        :error=>"Missing: toShow"
                    }
                }
            })
        end           
        it "should evaluate an toShow without other elements" do
            pk = Pk.new("n+n","2*n")
            
            json_ex = {:baseCase => nil,
                :inductiveStep=>{
                :hypothesis => nil,
                :show =>{:left=>["k","1","+", "k","1","+","+"], :right=>["2","k","1","+","*"]},
                :pre => [],
                :post => [],
                :uih => nil}}.to_json

            g = Grader.new(json_ex,pk)
            g.evaluate.should include({
                :correct=>false,
                :inductiveStep=>{
                    :result=>false,
                    :error=>"Missing: Use of IH",
                    :hypothesis=>{
                        :result=>false,
                        :error=>"Missing: Hypothesis"
                    },
                    :toShow=>{
                        :result=>true,
                        :error=>nil
                    }
                }
            })
        end      
        
        it "should evaluate an inductive step without an IH or toShow" do
            pk = Pk.new("n+n","2*n")
            
            json_ex = {:baseCase => nil,
                :inductiveStep=>{
                :hypothesis =>nil,
                :show =>nil,
                :pre => [{:left=>["k","1","+", "k","1","+","+"], :right=>["k","k","+","2","+"]}],
                :post => [{:left=>nil, :right=>["2","k","1","+","*"]}],
                :uih => {:left=>["k","k","+","2","+"], :right=>["2","k","*","2","+"]}}}.to_json

            g = Grader.new(json_ex,pk)
            g.evaluate.should include({
                :correct=>false,
                :inductiveStep=>{
                    :result=>true,
                    :error=>nil,
                    :hypothesis=>{
                        :result=>false,
                        :error=>"Missing: Hypothesis"
                    },
                    :toShow=>{
                        :result=>false,
                        :error=>"Missing: toShow"
                    }
                }
            })
        end 
        
        
        it "should evaluate a summation proof corectly" do
            pk = Pk.new("n+n","2*n")
            
            json_ex = {:baseCase => {:assumptions => {:b=>["1"]}, :equivalenceExpressions => [{:left=>["1", "1","+"], :right=>["2"]}]},
                :inductiveStep=>{
                :hypothesis => {:left=>["k","k","+"],:right=>["2","k","*"]},
                :show =>{:left=>["k","1","+", "k","1","+","+"], :right=>["2","k","1","+","*"]},
                :pre => [{:left=>["k","1","+", "k","1","+","+"], :right=>["k","k","+","2","+"]},{:left =>nil, :right =>["sum","i","1","|","2","|","k","1","+","|"]}],
                :post => [{:left=>nil, :right=>["2","k","1","+","*"]}],
                :uih => {:left=>["k","k","+","2","+"], :right=>["2","k","*","2","+"]}}}.to_json

            g = Grader.new(json_ex,pk)
            g.evaluate.should eq({
                :correct=>true,
                :baseCase => {
                    :result=>true,
                    :error=>nil
                },
                :inductiveStep=>{
                    :result=>true,
                    :error=>nil,
                    :hypothesis=>{
                        :result=>true,
                        :error=>nil
                    },
                    :toShow=>{
                        :result=>true,
                        :error=>nil
                    }
                }
            })
        end
        
        
    end
    
end