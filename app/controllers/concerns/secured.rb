module Secured
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request!
  end

  def authenticate_request!
    @user = System.authentication.current_user(request)
    unless @user
      render status: 401
    end
  end

  def current_user
    @user
  end
end
