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
end
