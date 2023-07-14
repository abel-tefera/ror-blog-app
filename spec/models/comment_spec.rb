require 'rails_helper'

RSpec.describe Comment, type: :model do
  @first_user = User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  @user2 = User.new(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')
  @post1 = Post.new(author: @first_user, title: 'Hello', text: 'This is my first post')

  op { Comment.create(post: @post1, author: @user2, text: 'Hi Tom!') }

  before { op.save }

  it 'post should have post field' do
    op.post = nil
    expect(op).to_not be_valid
  end

  it 'post should contain text' do
    op.text = nil
    expect(op).to_not be_valid
  end

  it 'post should have an author' do
    op.author = nil
    expect(op).to_not be_valid
  end

  it 'comment should belong to a post' do
    comment = Comment.reflect_on_association('post')
    expect(comment.macro).to eq(:belongs_to)
  end

  it 'comment should have an author' do
    comment = Comment.reflect_on_association('author')
    expect(comment.macro).to eq(:belongs_to)
  end

  it 'comment counter gets correctly updated' do
    first_user = User.create(
      name: 'Tom',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Teacher from Mexico.', posts_counter: 0
    )
    post1 = Post.create(author: first_user, title: 'Hello', text: 'This is my first post', comment_counter: 0,
                        likes_counter: 0)
    Comment.create(post: post1, author: first_user, text: 'Hi Tom!')
    commented_post = Post.find_by_author_id(post1.author_id)
    expect(commented_post.comment_counter).to eq 1
  end
end
