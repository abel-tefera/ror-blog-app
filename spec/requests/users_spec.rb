require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before(:each) do
    @user = User.create(name: 'Abel')
  end

  describe 'GET /index' do
    it 'returns http success' do
      get users_path
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end
    it 'renders the correct template' do
      get users_path
      expect(response).to render_template('index')
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get user_path(@user)
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end
    it 'renders the correct template' do
      get user_path(@user)
      expect(response).to render_template('show')
    end
  end
end
