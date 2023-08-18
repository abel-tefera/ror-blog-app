require 'rails_helper'

RSpec.describe Post, type: :model do
  subject do
    user = User.new(name: 'MySelf', photo: 'someurl.com', bio: 'Do what you must')
    Post.new(
      title: 'Hello world',
      text: 'My name is Jeff',
      author: user
    )
  end

  before { subject.save }

  it 'post should contain title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'post should have an author' do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'post cannot have negative likes count' do
    subject.likes_counter = -4
    expect(subject).to_not be_valid
  end

  it 'post cannot have negative comment count' do
    subject.comments_counter = -4
    expect(subject).to_not be_valid
  end

  it 'can retrive the five recent comments' do
    user = User.create(name: 'Abel', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    post = Post.create(author_id: user.id, title: 'Hello', text: 'This is my first post')

    comments = []
    5.times do |i|
      comment = Comment.create(author: user, post_id: post.id, text: "This is comment number #{i}")
      comments << comment
    end

    recent_comments = post.find_5_comments
    expect(recent_comments).to include(*comments)
  end
end
