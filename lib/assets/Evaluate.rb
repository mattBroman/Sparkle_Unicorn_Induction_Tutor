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
  
  #def initalize(assumptions, expressions)
  #  @assumptions = Hash.new
    #assumption.each do |assumption|
      
   # end
  #  @expressions = expressions
 # end
  
  
  
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
          raise RuntimeError, "Mismatched Parentheses" unless not operators.empty?
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
        raise RuntimeError, "Mismatched Parentheses"
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
      if @@operations[token] == nil 
        stack.push(token)
      else 
        left = stack.pop.to_f
        right = stack.pop.to_f
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
      tvals = ["1","2","3","4","5"]
      same = true
      

      
      tvals.each do |t|
         z = base.map{|x| x =="k" ? t : x}
         y = eqn.map{|x| x =="k" ? t : x}
         same &= (solve(z) == solve(y))
      end
      
      return same

      
  end
  
  
  
  
end