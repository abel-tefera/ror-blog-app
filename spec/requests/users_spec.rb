require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/users'
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end
    it 'renders the correct template' do
      get '/users'
      expect(response).to render_template('index')
    end
    it 'response body includes placeholder' do
      get '/users'
      expect(response.body).to include('List of users')
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/users/user_id'
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end
    it 'renders the correct template' do
      get '/users/user_id'
      expect(response).to render_template('show')
    end
    it 'response body includes placeholder' do
      get '/users/user_id'
      expect(response.body).to include('Showing user')
    end
  end
end
