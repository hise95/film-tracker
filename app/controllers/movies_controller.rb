class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]

  def index
    @movies = Movie.all
  end

  def show
    @comments = Comment.where(movie_id: params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
  end

  def create
    # @movie = Movie.new(movie_params)
    @movie = Movie.new(movie_params.merge(user_id: current_user.id))
    if @movie.save
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    if @movie.update(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy
    redirect_to root_path
  end

  private
    def set_movie
      @movie = Movie.find(params[:id])
    end

    def movie_params
      params.require(:movie).permit(:title, :description, :runtime, :released, :genre, :actors, :director, :imdb_rating)
    end
end
