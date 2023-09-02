class PostsController < ApplicationController
  load_and_authorize_resource except: %i[index show]

  def index
    @posts = Post.includes(comments: [:author]).where(author_id: params[:user_id])
    @user = User.find(params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @user = current_user
  end

  def create
    @post = Post.new(post_params)
    @user = current_user
    @post.author = @user

    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post was successfully created'
    else
      flash.now[:errors] = 'Invalid post!'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @user = @post.author
    @comments = Comment.find_by(post_id: @post.id)
    @likes = Like.find_by(post_id: @post.id)

    @comments.destroy
    @likes.destroy
    @post.destroy

    redirect_to user_posts_path(@user), notice: 'Post was successfully deleted'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
