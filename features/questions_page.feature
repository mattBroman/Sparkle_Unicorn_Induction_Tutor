Feature: Display a list a questions

	As a user
	I want view the list of questions
	So that I can looks at questions to solve

Background: a db of questions exist
  
  Given the following questions exist:
  | title                  | val        | p_k       | difficulty    | implies   | 
  | Title1                 | test val   | ...       |   1           |   testing |  
  | Title2                 | test val   | ...       |   1           |   testing |
  | Title3                 | test val   | ...       |   1           |   testing | 


  And I am on the questions page
  
Scenario: I see the questions listed
  
    Then I should see "Title1"
    Then I should see "Title2"
    Then I should see "Title3"
