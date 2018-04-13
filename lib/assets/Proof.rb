require "json"
require_relative "Pk.rb"
require_relative "Assumption.rb"
require_relative "EqExpression.rb"

class Proof
    
    def initialize(args,pk)
       @proof = JSON.parse(args)["proof"]
       
       @pk = pk
      
       @assumptions = Assumption.new(@proof.to_json)
       
       #pre IS
       @preq_json = @proof["pre"].to_json
       @preq = EqExpression.new(@preq_json, @assumptions,true,@pk)
       
       #post IS
       @postq_json = @proof["post"].to_json
       @postq = EqExpression.new(@preq_json, @assumptions,true,@pk)
       
       #IS
       @is_json = @proof["is"].to_json
       #is... create IS object for l ad r vals 
       
       
       #@eqs = EqExpression.new(@proof.to_json,@assumptions,true,@pk)
    
    
    end
    
    def evaluate
        
        #only assumption in proof should be k+1 for now
        if(@assumptions.evaluate != {"n"=>["k","1","+"]}) then
           return false 
        end
        
        #check head and tail of chain evaluate to be same as pk_l and pk_r
        return false unless @preq.headValid==true
        return false unless @postq.tailValid==true
        
        #check IS with tail of preq
        # preq tail should use pk_l
        #IS should use pk_r
        
        #run through all eqs and check symbolic equality
        #get head of preq
        #check all preq for equality
        #chck all postq for equality
        #check IS for equality



        #return @eqs.evaluate
    
    
    end

    
end