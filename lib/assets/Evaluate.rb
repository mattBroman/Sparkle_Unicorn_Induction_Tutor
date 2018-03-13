class Evaluator
  
    @@precedence = {
    '^' => 4,
    '*' => 3,
    '/' => 3,
    '+' => 2,
    '-' => 2,
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
end