require 'rails_helper'

RSpec.describe Comment, type: :model do
  @first_user = User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  @user2 = User.new(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')
  @post1 = Post.new(author: @first_user, title: 'Hello', text: 'This is my first post')

  subject { Comment.create(post: @post1, author: @user2, text: 'Hi Tom!') }

  before { subject.save }

  it 'post should have post field' do
    subject.post = nil
    expect(subject).to_not be_valid
  end

  it 'post should contain text' do
    subject.text = nil
    expect(subject).to_not be_valid
  end

  it 'post should have an author' do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'comment should belong to a post' do
    comment = Comment.reflect_on_association('post')
    expect(comment.macro).to eq(:belongs_to)
  end

  it 'comment should have an author' do
    comment = Comment.reflect_on_association('author')
    expect(comment.macro).to eq(:belongs_to)
  end

  it 'updates comments counter of the post' do
    user1 = User.create(
      name: 'Tom',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Teacher from Mexico.', posts_counter: 0
    )
    post1 = Post.create(author: user1, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                        likes_counter: 0)
    Comment.create(post: post1, author: user1, text: 'Hi Tom!')
    commented_post = Post.find_by_author_id(post1.author_id)
    expect(commented_post.comments_counter).to eq 1
  end

  it 'it increments the posts_counter of a user' do
    user = User.create(name: 'Abel', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                       bio: 'Teacher from Mexico.')

    expect(user.posts_counter).to eql 0

    Post.create(author_id: user.id, title: 'Hello', text: 'Text')
    user.reload
    expect(user.posts_counter).to eql 1

    Post.create(author_id: user.id, title: 'Hey', text: 'Some text')
    user.reload
    expect(user.posts_counter).to eql 2
  end
end
