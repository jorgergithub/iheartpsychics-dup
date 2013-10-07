require 'time_ext'

class HomeController < AuthorizedController
  before_filter :authenticate_user!, except: [:index, :apna, :confirmation]
  layout :select_layout

  def index
    return if go_home

    finish = Time.zone.parse("2013-12-01 00:00:00")
    diff = Time.diff(finish, Time.zone.now)

    @diff = {
      :month => ("%02d" % diff[:month]).split(""),
      :day => ("%02d" % (diff[:week] * 7 + diff[:day])).split(""),
      :hour => ("%02d" % diff[:hour]).split("")
    }

    @subscriber = Subscriber.new
  end

  def apna
  end

  def show
    go_home
  end

  def confirmation
  end

  protected

  def go_home
    return false unless current_user

    if current_user.client?
      redirect_to client_path
      return true
    elsif current_user.psychic?
      redirect_to psychic_path
      return true
    elsif current_user.rep?
      redirect_to customer_service_representative_path
      return true
    elsif current_user.admin?
      redirect_to admin_dashboard_path
      return true
    elsif current_user.manager_director?
      redirect_to admin_psychic_applications_path
      return true
    elsif current_user.website_admin?
      redirect_to admin_dashboard_path
      return true
    elsif current_user.accountant?
      redirect_to admin_invoices_path
      return true
    end
  end

  def select_layout
    if action_name == "show"
      return "application"
    elsif action_name == "apna"
      return "splash-nologo"
    else
      return "splash"
    end
  end
end
