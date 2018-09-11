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
    end

    # Setting the filtering option:
    if(params[:ratings])
      @ratings_filter = params[:ratings].keys
      session[:ratings] = params[:ratings]
    elsif(session[:ratings])
      @ratings_filter = session[:ratings].keys
    end

    # Redirect in case @sort_by or @ratings_filter is nil:
    if(@sort_by.nil? || @ratings_filter.nil?)

      flash.keep

      if(@sort_by.nil? && @ratings_filter.nil?)
        redirect_to movies_path(sort_by: "id",
                               ratings: Hash[@all_ratings.map {|r| [r, 1]}])

      elsif(@sort_by.nil?)
        redirect_to movies_path(sort_by: "id", ratings: session[:ratings])

      else
        redirect_to movies_path(sort_by: session[:sort_by],
                               ratings: Hash[@all_ratings.map {|r| [r, 1]}])

      end

      return
    end

    @movies = Movie.all.where(rating: @ratings_filter).order(@sort_by)
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
