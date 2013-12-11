class AuthorizedController < ApplicationController
  before_filter :authenticate_user!

  enable_authorization

  rescue_from CanCan::Unauthorized, :with => :unauthorized

  def current_psychic
    return unless current_user and current_user.psychic?
    current_user.psychic
  end

  def current_csr
    return unless current_user and current_user.rep?
    current_user.rep
  end

  def current_admin
    return unless current_user and current_user.admin?
    current_user.admin
  end

  def disable_pagination?
    params[:page] == 'all'
  end

  protected

  def store_location
    session[:return_to] = request.fullpath
  end

  def clear_stored_location
    session[:return_to] = nil
  end

  def return_to_stored_location
    stored_location = session[:return_to]
    clear_stored_location
    stored_location.to_s
  end

  def redirect_to_user_dashboard(user)
    case user.role
    when "client"
      client_path
    when "psychic"
      psychic_path
    else
      root_path
    end
  end

  def after_sign_in_path_for(resource)
    if session[:return_to].present?
      return_to_stored_location
    else
      redirect_to_user_dashboard(resource)
    end
  end
end
