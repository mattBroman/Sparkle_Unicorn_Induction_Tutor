Feature: Welcome message on home page

	As a user
	I want to be greeted when I open the site home
	So that I have a good experience with the site


Scenario: I see the welcome message when loading the site

# this is done with the cucumber training wheels mapping 
# w/ the support/paths.rb "path_to" function
When I go to the home page


# we defined this in our welcome_steps file
Then I should see the welcome message

	
