require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  user = User.create(name: 'Abel', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  Post.create(author_id: user.id, title: 'Hello', text: 'This is my first post')
  Post.create(author_id: user.id, title: 'Hello', text: 'This is my second post')
  Post.create(author_id: user.id, title: 'Hello', text: 'This is my third post')
  Post.create(author_id: user.id, title: 'Hello', text: 'This is my fourth post')

  before :each do
    visit user_path(user)
  end
end
