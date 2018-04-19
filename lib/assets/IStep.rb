require "json"
require_relative "Pk.rb"
require_relative "EqExpression.rb"
require_relative "Hypothesis.rb"
require_relative "Show.rb"
require_relative "Uih.rb"
require_relative "MyErrors.rb"




class IStep
    
    def initialize(args,pk)
       @istep = JSON.parse(args)["inductiveStep"]
       raise MissingError("inductive step") unless not @istep.nil?

       
       @pk = pk
      
       
     '''  #hypothesis
       
       @hypothesis = Hypothesis.new(@istep.to_json,@pk)
       
       
       
       #show
       
       @show = Show.new(@istep.to_json, @pk)
       '''
       
       
       #pre uih
       @preq_json = @istep["pre"].to_json
       @preq = EqExpression.new(@preq_json, nil,true,@pk)
       
       
       #uih
       #is... create IS object for l ad r vals 
       @uih = Uih.new(@istep.to_json,@pk)
       
       
       #post uih
       @postq_json = @istep["post"].to_json
       @postq = EqExpression.new(@postq_json, nil,true,@pk)
       
    end
    
    '''
    def evaluate_hypothesis
       @hypothesis.evaluate 
    end
    
    def evaluate_show
        @show.evaluate    
    end'''
    
    
    def evaluate
        
        #raise IncorrectError, "Hypothesis" unless evaluate_hypothesis
        #raise IncorrectError, "toShow" unless evaluate_show
        
       # return false unless evaluate_hypothesis
        #return false unless evaluate_show
        
        
        #check head and tail of chain evaluate to be same as pk_l and pk_r
        raise IncorrectError, "first expression does not follow p(k+1)" unless @preq.headValid==true
        
        #p "head valid"
        
        raise IncorrectError, "last expression does conclude p(k+1)" unless @postq.tailValid==true
        
        #p "tail valid"
        
        #check uih with tail of preq
        # preq tail should use pk_l
        #uih should use pk_r
        
        #p @preq.getTail
        raise IncorrectError, "use of IH" unless @uih.evaluate(@preq.getTail)
        
        #p "uih valid"
        
        @preq_tail= @preq.getTail
        
        #check all preq for equality
        raise IncorrectError, "pre 'use of IH' expressions are not equal" unless @preq.sym_evaluate(@preq_tail)==true
        
        #p "pre equal"
        
        #chck all postq for equality
        
        raise IncorrectError, "post 'use of IH' expressions are not equal" unless @postq.sym_evaluate(@preq_tail)==true

        #p "post equal"
        
        #check IS for equality
        raise IncorrectError, "'use of IH' expressions are not equal to work expression" unless @uih.evaluate_equal(@preq_tail)==true


        return true
    
    
    end

    
end