class LikesController < ApplicationController
  def create
    @user = ApplicationController.current_user
    @post = Post.find(params[:post_id])
    @like = Like.new(author_id: @user.id, post_id: @post.id)
    return unless @like.save

    redirect_to user_post_path(@user.id, @post)
  end
end