require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  User.create(name: 'Abel', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  User.create(name: 'Salamon', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  User.create(name: 'Grundy', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')

  users = User.all

  before :each do
    visit users_path
  end
  describe "page's content" do
    it "should show the user's name" do
      users.each { |user| expect(page).to have_content user.name }
    end

    it "should show the user's pic" do
      users.each { |user| expect(page).to have_css("img[src='#{user.photo}']") }
    end

    it 'should display the number of posts' do
      users.each { |user| expect(page).to have_content("Number of posts: #{user.posts.count}") }
    end
  end
  describe 'clicking on user link feature' do
    it 'redirects to show page' do
      @user = User.first
      click_link(href: user_path(@user))
      expect(page).to have_current_path(user_path(@user))
    end
  end
end
