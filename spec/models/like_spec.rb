require 'rails_helper'

RSpec.describe Like, type: :model do
  @user1 = User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  @post1 = Post.new(author: @user1, title: 'Hello', text: 'This is my first post')

  op { Like.create(post: @post1, author: @user2) }

  before { op.save }

  it 'like belongs to an author' do
    like = Like.reflect_on_association('author')
    expect(like.macro).to eq(:belongs_to)
  end

  it 'like belongs to a post' do
    like = Like.reflect_on_association('post')
    expect(like.macro).to eq(:belongs_to)
  end

  it 'likes counter should update' do
    user1 = User.create(
      name: 'Tom',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Teacher from Mexico.', posts_counter: 0
    )
    post1 = Post.create(author: user1, title: 'Hello', text: 'This is my first post', comment_counter: 0,
                        likes_counter: 0)
    Like.create(post: post1, author: user1)
    liked_post = Post.find_by_author_id(post1.author_id)
    expect(liked_post.likes_counter).to eq 1
  end
end