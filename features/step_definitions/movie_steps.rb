Given("the following movies exist:") do |table|

  table.rows.each do |row|
    @movie = Movie.new
    row.each_with_index do |value, index|
      @movie[table.headers[index]] = value
    end
    @movie.save
  end

end

Given(/^I check the following ratings: (.*)$/) do |ratings|

  ratings_list = ratings.split(", ") # Splits the ratings given.

  ratings_list.each do |rating|
    check "ratings[#{rating}]"
  end

end

Given("I check all ratings") do

  Movie.all_ratings.each do |rating|
    check "ratings[#{rating}]"
  end

end

Given(/^I uncheck the following ratings: (.*)$/) do |ratings|

  ratings_list = ratings.split(", ") # Splits the ratings given.

  ratings_list.each {
    |rating|
    uncheck "ratings[#{rating}]"
  }

end

Given(/^the movie with title "(.*)" and rating "(.*)" exists$/) do |title, rating|
  steps %(
  When I follow "Add new movie"
  Then I should be on the Create New Movie page
  When I fill in "Title" with "#{title}"
  And I select "#{rating}" from "Rating"
  And I press "Save Changes"
  Then I should be on the RottenPotatoes home page
  And I should see "#{title}"
  )
end

Then(/^I should see "(.*)" before "(.*)"$/) do |movie1, movie2|

  if page.respond_to? :should
    expect(page).to have_content(/#{movie1}.*#{movie2}/m)
  else
    assert page.has_content?(/#{movie1}.*#{movie2}/m)
  end

end

Then("I should see all of the movies") do

  titles = Movie.all.each.map {
    |movie|
    movie.title
  }

  if page.respond_to? :should
    titles.each {
      |title|
      expect(page).to have_content(title)
    }
  else
    titles.each {
      |title|
      assert page.has_content?(title)
    }
  end

end

Then(/^the director of "([^\"]*)" should be "([^\"]*)"$/) do |title, director|
  @movie = Movie.find_by_title(title)
  expect(@movie.director).to eq(director)
end
