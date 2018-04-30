require_relative "MyErrors.rb"
require_relative "Base.rb"

class Evaluator
  
  
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
  
  
  #new operations should contain these functions
  @@complex_operations={
    "sum" => {
      :eval=>:summation,
      :parse=> :sum_prod_parse,
      :post=>:sum_prod_postfix
    },
    "product" => {
      :eval=>:product,
      :parse=> :sum_prod_parse,
      :post=>:sum_prod_postfix

    }
  }
  

  def tokenize(inp)

    kw = []
    inpt = []
    bkw=nil
    @@complex_operations.each do |e,v| 
      
      #index of first keyword
      ind= inp.index(e)
      
      #set bkw lowest index keyword
      if(ind) then
         kw = [ind,e]

        if(bkw.nil? or bkw[0] > kw[0]) then
          bkw = kw
        end
      end

    end
    
    #split at best keyword
    if(bkw) then
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
        
      elsif @@complex_operations.include? token 
      
      
        method(@@complex_operations[token][:post]).call(token,tokens, postfix)

        
        
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
      if @@complex_operations.include? token
        method(@@complex_operations[token][:parse]).call(postfix,stack,method(@@complex_operations[token][:eval]))

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
  

  #stubbed with a simple eqn    
  def sym_eq_equal(base,eqn)
      return sym_eq_equal_simple(base,eqn)

  end
  
  
  
  #simple check
  def sym_eq_equal_simple(base, eqn)
    
      s = BaseCase.getbasevalue[0].to_i
      
      #base -> base+5 to check symbolically      
      tvals = (s..(s+5)).to_a.map(&:to_s)
      same = true
      
      tvals.each do |t|
         z = base.map{|x| x =="k" ? t : x}
         y = eqn.map{|x| x =="k" ? t : x}
         same &= (solve(z.clone) == solve(y.clone))
         
      end
      
      return same

  end
  
  
  #complex operations here
  
  #sum/product
  def summation(lower_bound,upper_bound,eq)
    sum_prod_eval(lower_bound,upper_bound,eq,:+)
  end
    
  def product(lower_bound,upper_bound,eq)
    sum_prod_eval(lower_bound,upper_bound,eq,:*)
  end
  
  
  def sum_prod_postfix(token, tokens, postfix)
          
    #pop '\' and push sum
    postfix.pop
    postfix.push(token)
    
    
    #push lower
    
    #_
    tokens.shift
    #{
    tokens.shift

    #push var name
    postfix.push(tokens.shift)
    
    #=
    tokens.shift
    
    lower = []
    token = tokens.shift
    while(token != "}" and not tokens.empty?) do
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
    tokens.shift
    #{
    tokens.shift

    upper = []
    token = tokens.shift
    while(token != "}" and not tokens.empty?) do
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
    tokens.shift

    
    eq = []
    token = tokens.shift
    while(token != "}" and not tokens.empty?) do
      eq << token
      token = tokens.shift
    end
    eq_post = shunting_yard(eq)

    while not eq_post.empty? do
      postfix.push(eq_post.pop)
    end
    postfix.push("|")
    
    
  end
  
  
  def sum_prod_parse(postfix,stack,func)
    #lower bound
    lower = []
    
    var_l = postfix.shift
    top = postfix.shift
    
    while(top != "|" and not postfix.empty?) do
      lower << top
      top = postfix.shift
    end
    
    #lower can be an equation or numeric value so solve for both cases
    lower = solve(lower)
    
    #map to use iterating varibale for later
    lower_v = {:var => var_l, :value => lower}
    
    #upper bound
    upper = []
    
    top = postfix.shift
    while(top != "|" and not postfix.empty?) do
      upper << top
      top = postfix.shift
    end
    
    upper = solve(upper)
    
    #equation
    eq = []
    top = postfix.shift

    #incase there are nestable operations in the equation    
    inner = 0
  
    while(top != "|" or inner!=0 and not postfix.empty?) do
      eq << top
      if top=="|" then
        inner-=1
      
      elsif @@complex_operations.include? top
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
  
  
end