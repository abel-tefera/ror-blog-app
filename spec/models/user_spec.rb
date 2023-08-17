require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    user = User.create(name: 'John Wick', photo: 'someurl.com', bio: 'The BabaYaga', posts_counter: 0)
    3.times do
      Post.create(
        title: 'Random',
        text: 'Random',
        author: user
      )
    end
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
    expect(subject.three_recent_posts.length).to eq 0
  end
end
