require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.new(name: 'MySelf', photo: 'someurl.com', bio: 'Do what you must', posts_counter: 0)
  op do
    Post.new(
      title: 'XRP gets clarity',
      text: 'XRP is the Standard',
      author: user
    )
  end

  before { op.save }

  it 'post should contain title' do
    op.title = nil
    expect(op).to_not be_valid
  end

  it 'post should have an author' do
    op.author = nil
    expect(op).to_not be_valid
  end



  it 'post cannot have negative likes count' do
    op.likes_counter = -4
    expect(op).to_not be_valid
  end

  it 'post cannot have negative comment count' do
    op.comment_counter = -4
    expect(op).to_not be_valid
  end
end