class Api::AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login
  protect_from_forgery with: :null_session

  def login
    @user = User.find_by_email(params[:email])
    if @user.password == params[:password]
      render json: { error: 'unauthorized' }, status: :unauthorized
    else
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token:, exp: time.strftime('%m-%d-%Y %H:%M'), name: @user.name }, status: :ok
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
