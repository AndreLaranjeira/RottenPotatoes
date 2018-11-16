Feature: User can manually delete a movie

Scenario: Delete a movie
	Given I am on the RottenPotatoes home page
	And the movie with title "Men in Black" and rating "PG-13" exists
  When I follow "More about Men in Black"
  And follow "Delete"
  Then I should be on the RottenPotatoes home page
	And I should see "Men in Black was deleted!"
