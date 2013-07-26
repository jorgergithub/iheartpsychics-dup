class AuthorizedController < ApplicationController
  before_filter :authenticate_user!

  def current_client
    return unless current_user and current_user.client?
    current_user.client
  end

  def current_psychic
    return unless current_user and current_user.psychic?
    current_user.psychic
  end

  def current_csr
    return unless current_user and current_user.rep?
    current_user.rep
  end
end
