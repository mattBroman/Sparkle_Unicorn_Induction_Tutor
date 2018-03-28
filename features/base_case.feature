Feature: Evaluate the correctness of a base case

	As a user
	I want to see if my base case is correct
	So that I can verify the grader will accept my base case as true


Background: a db of questions exist
  
  Given the following questions exist:
  | title                  | val        | p_k       | difficulty    | implies   | 
  | Title1                 | test val   | ...       |   1           |   testing |  
  | Title2                 | test val   | ...       |   1           |   testing |
  | Title3                 | test val   | ...       |   1           |   testing | 


  And I am on the questions page


#@javascript
Scenario: I see true when my base case is graded

    When I follow "Title1"
    
    
    Then type my correct base case for simple arithmetic
    
    Then I press "submit"
    Then I press "submit"

    Then I should see true in the responce textbox
