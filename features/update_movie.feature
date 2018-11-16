Feature: User can manually update a movie

Scenario: Update a movie
	Given I am on the RottenPotatoes home page
	And the movie with title "Men in Black" and rating "PG-13" exists
  When I follow "More about Men in Black"
  And follow "Edit"
  When I fill in "Director" with "Barry Sonnenfeld"
  And I press "Update Movie Info"
  Then I should be on the details page for "Men in Black"
	And I should see "Men in Black was successfully updated!"
  And I should see "Barry Sonnenfeld"
