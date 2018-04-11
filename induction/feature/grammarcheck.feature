Feature: checking grammar
  As a user
  I want to be told whether or not I am using the proper grammar
  So I can have my proof checked by the site
  
Scenario: User enters correct grammer
  When I enter the correct grammar
  Then I should see that the update box reads "Good!"
  
Scenario: User enters incorrect grammar
  When I enter the incorrect grammar
  Then I should see that the update box reads "Bad!"
  
  