class AuthorizedController < ApplicationController
  before_filter :authenticate_user!

  def current_client
    return unless current_user and current_user.client?
    current_user.client
  end
end
