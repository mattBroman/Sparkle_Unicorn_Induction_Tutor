require "json"
require_relative "Pk.rb"
require_relative "EqExpression.rb"



class Uih
    
   def initialize(args,pk)
       
        @pk = pk
        
        @uih = JSON.parse(args)["uih"]
        raise MissingError, "Use of IH" unless not @uih.nil?
        
        @left = @uih["left"]
        
        @right = @uih["right"]

   end
    
    def evaluate(eqx)

        #sub in k for n on pk
        @pk_k = @pk.evaluate("k")
        
        @pk_l = @pk_k["left"]
        @pk_r = @pk_k["right"]
        
        
        if(@left.nil?) then
            @left = eqx
        end
        
    
        
        if not (@left.join.include? @pk_l.join) then
           
            raise IncorrectError, "Use of IH"
        end
        
        
        if not (@right.join.include? @pk_r.join) then
            raise IncorrectError, "Use of IH"
        end
        
        
        
        return true
        

    end
    
    
    def evaluate_equal(eqx) 
        e = Evaluator.new
        
        eq = e.sym_eq_equal(eqx,@left)
        
        # p eq
        #check equality of left and right
        eq &= e.sym_eq_equal(@left,@right)
        
        #p eq
        
        return eq
        
    end
    
    
end