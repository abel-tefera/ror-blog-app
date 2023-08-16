require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.new(name: 'MySelf', photo: 'someurl.com', bio: 'Do what you must', posts_counter: 0)
  subject do
    Post.new(
      title: 'XRP gets clarity',
      text: 'XRP is the Standard',
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
end
