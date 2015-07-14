class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :require_authenticated_user, only: :create


  def create
    user = User.find_or_create_from_auth_hash(auth_hash)
    login!(user)

    redirect_to back_or_default(root_path)
  end

  def destroy
    logout!

    redirect_to '/login'
  end


private
  def auth_hash
    request.env['omniauth.auth']
  end
end
