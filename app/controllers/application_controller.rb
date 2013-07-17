class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # protected

  # def stored_location_for(resource)
  #   nil
  # end

  # def after_sign_in_path_for(resource)
  #   if resource.client?
  #     redirect_to clients_path
  #     return
  #   else
  #     redirect_to "/"
  #     return
  #   end
  # end
end
