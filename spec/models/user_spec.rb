require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    user = User.create(name: 'John Wick', photo: 'someurl.com', bio: 'The BabaYaga', posts_counter: 0)
    user
  end

  before { subject.save }

  it 'user should have a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'post counter should not be negative' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'should be valid' do
    expect(subject).to be_valid
  end

  it 'can fetch a users three recent posts' do
    3.times do
      Post.create(
        title: 'Random',
        text: 'Random',
        author: subject
      )
    end
    user = User.find_by_id(subject.id)
    expect(user.three_recent_posts.length).to eq 3
  end

  describe '#recent_three_posts method' do
    let(:user) { create(:user) }

    it 'it returns the last 3 posts of a user' do
      user = User.create(name: 'Harriet', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')

      first_post = Post.create(author: user, title: 'Hello', text: 'This is my first post')
      second_post = Post.create(author: user, title: 'Happy', text: 'This is my second post')
      third_post = Post.create(author: user, title: 'Sad', text: 'This is my third post')
      fourth_post = Post.create(author: user, title: 'Joy', text: 'This is my fourth post')

      recent_posts = user.three_recent_posts

      expect(recent_posts).to_not include(first_post)
      expect(recent_posts).to include(fourth_post, third_post, second_post)
    end
  end
end
