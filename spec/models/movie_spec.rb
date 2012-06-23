require 'spec_helper'

describe Movie do

  describe 'given the director, find all the movies by that director' do
    it 'should get a call to find similar movies and return those movies' do
      @fake_results = [mock('Movie'), mock('Movie')]
      @fake_movie = mock('movie1', :id => '0', :title => 'Star Wars', :director => 'George Lucas')
      Movie.should_receive(:find_by_director).with('George Lucas').and_return(@fake_results)
      Movie.find_by_director(@fake_movie.director)
    end
    it 'find all movies by director' do
      @fake_min_movie = {:rating => 'G', :director => 'Bob Dole'}
      movie = Movie.create! @fake_min_movie
      Movie.find_by_director(movie.director).should eq([movie])
    end
  end
  describe 'all ratings' do
    it 'should return all raitings' do
      Movie.all_ratings.should == ["G", "PG", "PG-13", "NC-17", "R"]
    end
  end
end