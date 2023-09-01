class Api::V1::PostsController < ApplicationController
  def index
    @posts = Post.includes(comments: [:author]).where(author_id: params[:user_id])

    if @posts
      render json: @posts.to_json, status: :ok
    else
      render json: { status: 'Error', errors: @posts.errors }
    end
  end
end
