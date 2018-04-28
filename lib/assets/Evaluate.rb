require_relative "MyErrors.rb"
require_relative "Base.rb"

class Evaluator
  
  
    @@base = 0
  
    @@precedence = {
    '^' => 4,
    '*' => 3,
    '/' => 3,
    '+' => 2,
    '-' => 2,
  }
  
  @@operations = {
    '^' => lambda { |x, y| x ** y },
    '*' => lambda { |x, y| x * y },
    '/' => lambda { |x, y| x / y },
    '+' => lambda { |x, y| x + y},
    '-' => lambda { |x, y| x - y}
  }
  
  @@nestable_operations={
    "sum" => :summation,
    "product" => :product
  }
  

  def tokenize(inp)
    p inp
    tokens = []
    kw = []
    inpt = []
    bkw=nil
    @@nestable_operations.each do |e,v| 
      
      ind= inp.index(e)
      
      if(ind) then
         kw = [ind,e]

        if(bkw.nil? or bkw[0] > kw[0]) then
          bkw = kw
        end
      end
     
      

    end
    
    if(bkw) then
      p "bsdjkfjkg"
      p bkw
      inpt << inp[0..bkw[0]-1].chars
      inpt << bkw[1]
      inpt << tokenize(inp[(bkw[0]+bkw[1].size)..-1])
      
    else
      inpt << inp.chars
      
    end
    
   
      
      
    return inpt.flatten
    
    
   
   
 
    
  end
  
  
  def shunting_yard(tokens)
    postfix = Array.new
    operators = Array.new
    
    complex_op = 0
    
    #tokens.each do |token|
    while(not tokens.empty?) do
      token = tokens.shift
      #operator
      if @@precedence[token]
        if operators.empty?
          operators.push(token)
        else
          while !operators.empty? and pop_stack?(operators, token)
            postfix.push(operators.pop)
          end
          operators.push(token)
        end
        
      elsif @@nestable_operations.include? token 
        #push sum
        postfix.pop
        postfix.push(token)
        
        
        #push lower
        
        #_
        token = tokens.shift
        #{
        token = tokens.shift

        #push var name
        postfix.push(tokens.shift)
        
        #=
        token = tokens.shift
        
        lower = []
        token = tokens.shift
        while(token != "}") do
          lower << token
          token = tokens.shift
        end
        lower_post = shunting_yard(lower)
        while not lower_post.empty? do
          postfix.push(lower_post.pop)
        end
        postfix.push("|")
        #push upper
       
         #^
        token = tokens.shift
        #{
        token = tokens.shift

        upper = []
        token = tokens.shift
        while(token != "}") do
          upper << token
          token = tokens.shift
        end
        upper_post = shunting_yard(upper)

        while not upper_post.empty? do
          postfix.push(upper_post.pop)
        end
        
        postfix.push("|")
        #push eq

        #{
        token = tokens.shift

        
        eq = []
        token = tokens.shift
        while(token != "}") do
          eq << token
          token = tokens.shift
        end
        eq_post = shunting_yard(eq)

        while not eq_post.empty? do
          postfix.push(eq_post.pop)
        end
        postfix.push("|")
        
        
      else #number or parentheses
        if token == '('
          operators.push(token)
        elsif token == ')'
          while operators[-1] != '(' and !operators.empty?
            postfix.push(operators.pop)
          end
          raise IncorrectError, "Mismatched Parentheses" unless not operators.empty?
          operators.pop
        else  
          postfix.push(token)
        end
      end
    end
    
    while not operators.empty?
      unless operators[-1] == '(' or operators[-1] == ')'
        postfix.push(operators.pop)
      else
        raise IncorrectError, "Mismatched Parentheses"
      end
    end
    
    return postfix
  end
  
  def pop_stack?(stack, token)
    stack[-1] != '(' and @@precedence[token] <= @@precedence[stack[-1]]
  end
  
  def solve(postfix)
    stack = Array.new
    while !postfix.empty?
      token = postfix.shift
      if @@nestable_operations.include? token
        sum_prod_parse(postfix,stack,method(@@nestable_operations[token]))
        
      elsif @@operations[token] == nil 
        stack.push(token)

      else  
        left = stack.pop
        right = stack.pop
        
        raise IncorrectError, "operator mismatch " unless left
        raise IncorrectError, "operator mismatch" unless right
        
        raise MissingError, "bad variable" unless not  left =~ /[a-zA-Z]/
        raise MissingError, "bad variable" unless not  right =~ /[a-zA-Z]/

        
        
        left = left.to_f
        right = right.to_f
        
        stack.push(@@operations[token].call(right, left))
      end
    end
    stack.pop.to_f
  end
  
  def evaluate tokens
    solve(shunting_yard(tokens))
  end
  
  
  
  
  def summation(lower_bound,upper_bound,eq)
    sum_prod_eval(lower_bound,upper_bound,eq,:+)
  end
    
  def product(lower_bound,upper_bound,eq)
    sum_prod_eval(lower_bound,upper_bound,eq,:*)
  end
  
  
  def sum_prod_parse(postfix,stack,func)
    #lower
    #evaluate and store variable globally with value
   
    lower = []
    
    var_l = postfix.shift
    top = postfix.shift
    
 
    
    while(top != "|") do
      lower << top
      top = postfix.shift
    end
    
    lower = solve(lower)
    
    lower_v = {:var => var_l, :value => lower}
    
    #upper
    #evaluate using possibly globals
    upper = []
    
    
    top = postfix.shift
    while(top != "|") do
      upper << top
      top = postfix.shift
    end
    
    upper = solve(upper)
    
            
   
    #equation
    #parse out
    eq = []
    top = postfix.shift
    
    inner = 0
  
    while(top != "|" or inner!=0) do
      eq << top
      if top=="|" then
        inner-=1
      
      elsif @@nestable_operations.include? top
        inner += 3
      end
      
      top = postfix.shift
    end
    
   
    stack.push(func.call(lower_v,upper,eq))
  
    
    
  end
  

  
  def sum_prod_eval(lower_bound, upper_bound, eq,method)
   
    sum = []
    (lower_bound[:value].to_i..upper_bound.to_i).each do |i| 
      eqt = eq.clone
      eqt.map! { |x| x == lower_bound[:var] ? i.to_s : x }
      
     
      sum << solve(eqt)
      
    end
    
    return sum.inject(method)
    
    
  end
  
  
  
  
  #stubbed with a simple eqn    
  def sym_eq_equal(base,eqn)
      return sym_eq_equal_simple(base,eqn)

  end
  
  
  
  #simple check
  def sym_eq_equal_simple(base, eqn)
    
      s = BaseCase.getbasevalue[0].to_i
      
      
      tvals = (s..(s+5)).to_a.map(&:to_s)
      #tvals = ["1","2","3","4","5"]
      same = true
      

      
      tvals.each do |t|
         z = base.map{|x| x =="k" ? t : x}
         y = eqn.map{|x| x =="k" ? t : x}
         same &= (solve(z.clone) == solve(y.clone))
         
      end
      
      return same

      
  end
  
  
  
  
end