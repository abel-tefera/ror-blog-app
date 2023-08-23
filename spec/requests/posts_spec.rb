require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/users/user_id/posts'
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end
    it 'renders the correct template' do
      get '/users/user_id/posts'
      expect(response).to render_template('index')
    end
    it 'response body includes placeholder' do
      get '/users/user_id/posts'
      expect(response.body).to include("List of a user's posts")
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/users/user_id/posts/post_id'
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end
    it 'renders the correct template' do
      get '/users/user_id/posts/post_id'
      expect(response).to render_template('show')
    end
    it 'response body includes placeholder' do
      get '/users/user_id/posts/post_id'
      expect(response.body).to include("Showing a user's post")
    end
  end
end
