class Api::V1::CommentsController < ApplicationController
  before_action :authorize_request, only: :create
  # protect_from_forgery with: :null_session

  def index
    @comments = Comment.where(post_id: params[:post_id])
    render json: @comments.to_json, status: :ok
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.author = @user

    if @comment.save
      render json: @comment.to_json, status: :ok
    else
      render json: { status: 'Not Created' }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
