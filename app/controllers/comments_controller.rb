class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = Comment.new(comment_params.merge(movie_id: params[:movie_id], user_id: current_user.id))
    if @comment.save
      redirect_to movie_path(params[:movie_id])
    else
      render :new
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to movie_path(@comment.movie)
    else
      render :edit
    end

  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
