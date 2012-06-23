require 'spec_helper'

describe MoviesController do
  describe 'searching by director' do
    before(:each) do
      @fake_movie = mock('movie1', :id => '0', :title =>'Star Wars', :director => 'George Lucas')
      @fake_min_movie = {:rating => 'G', :director => 'Bob Dole'}
      @fake_results = [mock('Movie'), mock('Movie')]
      @fake_movie_no_director = mock('movie1', :id => '0', :title => 'Star Wars')
    end
    describe "GET same_director" do
      describe "with director" do
        it "assigns all movies as @movies" do
          movie = Movie.create! @fake_min_movie
          get :same_director, :id => movie.id
          assigns(:movies).should eq([movie])
        end
      end
      describe "without director" do
        it "redirects to the homepage" do
          movie = Movie.create!
          get :same_director, :id => movie.id
          response.should redirect_to(movies_path)
        end
      end
    end
    describe 'show form for adding a movie' do
      it 'should show the form to create new movie' do
        get :new
        response.should render_template('new')
      end
    end
    describe 'create a movie' do
      it 'should create a movie' do
        movie = mock('Movie', :title => 'The Help')
        Movie.should_receive(:create!).and_return(movie)
        post :create, :movie => movie
        response.should redirect_to(movies_path)
      end
    end
    describe "GET show" do
      it "assigns the requested movies as @movie" do
        movie = Movie.create! @fake_min_movie
        get :show, :id => movie.id
        assigns(:movie).should eq(movie)
      end
    end
    describe "GET edit" do
      it "retrieve movie for edit" do
        Movie.stub!(:find).with('0').and_return(@fake_movie)
        get :edit, :id => @fake_movie.id
        assigns(:movie).should eq(@fake_movie)
      end
    end
    describe 'go to edit a movie info' do
      it 'should show the form to edit the movie' do
        movie = mock('Movie', :title => 'Aladin')
        Movie.should_receive(:find).with('1').and_return(movie)
        get :edit, :id => '1'
        response.should render_template('edit')
      end
    end

    describe 'update a movie info' do
      it 'should save the updated movie information' do
        movie = mock('Movie', :id => '1', :title => 'Gladiator')
        Movie.should_receive(:find).with('1').and_return(movie)
        movie.should_receive(:update_attributes!)
        put :update, :id => '1', :movie => movie
        response.should redirect_to movie_path(movie)
      end
    end

    describe 'delete a movie' do
      it 'should destroy the movie' do
        movie = mock('Movie', :id => '1', :title => 'The Help')
        Movie.should_receive(:find).with('1').and_return(movie)
        movie.should_receive(:destroy)
        delete :destroy, :id => '1'
        response.should redirect_to(movies_path)
      end
    end
    it 'should list all movies' do
      fake_results = [mock('Movie'), mock('Movie')]
      Movie.should_receive(:find_all_by_rating).and_return(fake_results)
      get :index
      response.should render_template('index')
    end
    it 'should list all movies, sorted by title' do
      get :index, {:sort => 'title', :ratings => 'PG'}
      response.should redirect_to(:sort => 'title', :ratings => 'PG')
    end
    it 'should list all movies, sorted by release_date' do
      get :index, {:sort => 'release_date', :ratings => 'PG'}
      response.should redirect_to(:sort => 'release_date', :ratings => 'PG')
    end
    it 'should list all movies with rating PG' do
      get :index, {:ratings => 'PG'}
      response.should redirect_to(:ratings => 'PG')
    end
  end
end