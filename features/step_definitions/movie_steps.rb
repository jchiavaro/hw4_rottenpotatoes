# Add a declarative step here for populating the DB with movies.
MOVIES = [
  {:title=>'Star Wars', :rating=> 'PG', :director=> 'George Lucas', :release_date=> '1977-05-25'},
  {:title=>'Blade Runner', :rating=> 'PG', :director=> 'Ridley Scott', :release_date=> '1982-06-25'},
  {:title=>'Alien', :rating=> 'R', :director=> '', :release_date=> '1979-05-25'},
  {:title=>'THX-1138', :rating=> 'R', :director=> 'George Lucas', :release_date=> '1971-03-11'}
]

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |title, director|
  movie = Movie.find_by_title(title)
  movie.director.should == director
end