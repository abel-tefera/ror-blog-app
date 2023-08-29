require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  before(:each) do
    @user = User.create(name: 'Abel')
    @post = @user.posts.create!(title: 'Hi', text: 'My name is Jeff')
  end

  describe 'GET /index' do
    it 'returns http success' do
      get user_posts_path(@user)
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end
    it 'renders the correct template' do
      get user_posts_path(@user)
      expect(response).to render_template('index')
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get user_post_path(@user, @post)
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end
    it 'renders the correct template' do
      get user_post_path(@user, @post)
      expect(response).to render_template('show')
    end
  end
end
