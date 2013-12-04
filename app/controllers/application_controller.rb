class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :find_page_seo
  before_action :find_horoscope
  before_action :configure_permitted_parameters, if: :devise_controller?
  around_action :user_time_zone, if: :current_user

  layout :layout_by_resource

  enable_authorization

  rescue_from CanCan::Unauthorized, :with => :unauthorized

  def page_seo
    @page_seo
  end

  protected

  def find_horoscope
    @horoscope = Horoscope.last_by_date
  end

  def user_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:login, :email, :username, :password, :first_name, :last_name, :create_as)
    end
  end

  def layout_by_resource
    if devise_controller?
      "login"
    else
      "application"
    end
  end

  def unauthorized
    if request.xhr?
      render :nothing => true, :status => :unauthorized
    else
      render :file => 'public/401', :layout => nil, :status => 401
    end
  end

  def find_page_seo
    @page_seo = PageSeo.for(request.path)
    Rails.logger.info "SEO: #{@page_seo.inspect}"
  end

  # Overwriting the sign_out redirect path method
  # def after_sign_out_path_for(resource_or_scope)
  #   new_user_session_path
  # end
end
