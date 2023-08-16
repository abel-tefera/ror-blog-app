require 'rails_helper'

RSpec.describe Like, type: :model do
  @user1 = User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  @post1 = Post.new(author: @user1, title: 'Hello', text: 'This is my first post')

  subject { described_class.create(post: @post1, author: @user2) }

  before { subject.save }

  it 'like belongs to an author' do
    like = Like.reflect_on_association('author')
    expect(like.macro).to eq(:belongs_to)
  end

  it 'like belongs to a post' do
    like = Like.reflect_on_association('post')
    expect(like.macro).to eq(:belongs_to)
  end
end
