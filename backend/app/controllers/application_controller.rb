class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  skip_before_action :verify_authenticity_token, raise: false, if: :devise_controller?

  def session_hash
    params[:session_hash] || SecureRandom.base64(16)
  end
end
