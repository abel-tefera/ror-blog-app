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

  describe "page's content" do
    it "should show the user's pic" do
      expect(page).to have_css("img[src='#{user.photo}']")
    end

    it "should show the user's name" do
      expect(page).to have_content user.name
    end

    it 'should display the number of posts' do
      expect(page).to have_content("Number of posts: #{user.posts.count}")
    end

    it "should show the user's bio" do
      expect(page).to have_content(user.bio.to_s)
    end

    it "should show the user's three posts only" do
      user.recent_three_posts.each { |post| expect(page).to have_content(post.text.to_s) }
      expect(page).not_to have_content(first_post.text.to_s)
    end

    it "should see a link to 'See all posts'" do
      expect(page).to have_link('See all posts')
    end
  end

  describe 'interactions on page' do
    it "redirects to post's show page when post is clicked" do
      click_link(href: user_post_path(user, last_post))
      expect(page).to have_current_path(user_post_path(user, last_post))
    end

    it "redirects to post's index page when 'See all post' clicked" do
      click_link('See all post')
      expect(page).to have_current_path(user_posts_path(user))
    end
  end
end
