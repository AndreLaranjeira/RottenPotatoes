# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController

  def index
    @all_ratings = Movie.all_ratings

    # Setting the sorting option:
    if(params[:sort_by])
      @sort_by = params[:sort_by]
      session[:sort_by] = params[:sort_by]
    elsif(session[:sort_by])
      @sort_by = session[:sort_by]
    else
      @sort_by = nil
    end

    # Setting the filtering option:
    if(params[:ratings])
      @ratings_filter = params[:ratings].keys
      session[:ratings] = params[:ratings]
    elsif(session[:ratings])
      @ratings_filter = session[:ratings].keys
    else
      @ratings_filter = @all_ratings
    end

    @movies = Movie.all.where(rating: @ratings_filter).group(@sort_by)
  end

  def show
    id = params[:id]
    @movie = Movie.find(id)
  end

  def new
    @movie = Movie.new
  end

  def create
    #@movie = Movie.create!(params[:movie]) #did not work on rails 5.
    @movie = Movie.create(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created!"
    redirect_to movies_path
  end

  def movie_params
    params.require(:movie).permit(:title,:rating,:description,:release_date)
  end

  def edit
    id = params[:id]
    @movie = Movie.find(id)
    #@movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    #@movie.update_attributes!(params[:movie])#did not work on rails 5.
    @movie.update(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated!"
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find params[:id]
    @movie.destroy
    flash[:notice] = "#{@movie.title} was deleted!"
    redirect_to movies_path
  end
end
