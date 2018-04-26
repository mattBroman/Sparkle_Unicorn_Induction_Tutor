require_relative "MyErrors.rb"
class Evaluator
  
    @@precedence = {
    '^' => 4,
    '*' => 3,
    '/' => 3,
    'sum' =>3,
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
  

  
  
  
  def shunting_yard(tokens)
    postfix = Array.new
    operators = Array.new
    
    tokens.each do |token|
      #operator
      unless @@precedence[token] == nil
        if operators.empty?
          operators.push(token)
        else
          while !operators.empty? and pop_stack?(operators, token)
            postfix.push(operators.pop)
          end
          operators.push(token)
        end
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
      if token == "sum"
        sum_prod_parse(postfix,stack,method(:summation))
      elsif token == "product"
        sum_prod_parse(postfix,stack,method(:product))
        
      elsif @@operations[token] == nil 
        stack.push(token)

      else  
        left = stack.pop
        right = stack.pop
        
        raise IncorrectError, "operator mismatch " unless left
        raise IncorrectError, "operator mismatch" unless right
        
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
    
    #innersum so avoid 3 | chars
    if(top=="sum" or top == "product") 
      innersum = 3
    end
    
    innersum = 0
    
    while(top != "|" or innersum!=0) do
      eq << top
      if top=="|" then
        innersum-=1
      
      elsif top=="sum" or top == "product"
        innersum +=3
      end
      
      top = postfix.shift
    end
    
   
    stack.push(func.call(lower_v,upper,eq))
  
    
    
  end
  
  def summation(lower_bound,upper_bound,eq)
    sum_prod_eval(lower_bound,upper_bound,eq,:+)
  end
    
  def product(lower_bound,upper_bound,eq)
    sum_prod_eval(lower_bound,upper_bound,eq,:*)
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
      tvals = ["1","2","3","4","5"]
      same = true
      

      
      tvals.each do |t|
         z = base.map{|x| x =="k" ? t : x}
         y = eqn.map{|x| x =="k" ? t : x}
         same &= (solve(z.clone) == solve(y.clone))
         
      end
      
      return same

      
  end
  
  
  
  
end