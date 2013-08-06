class HomeController < AuthorizedController
  def show
    if current_user.client?
      redirect_to client_path
      return
    elsif current_user.psychic?
      redirect_to psychic_path
      return
    elsif current_user.rep?
      redirect_to customer_service_representative_path
      return
    elsif current_user.admin?
      redirect_to admin_dashboard_path
      return
    elsif current_user.manager_director?
      redirect_to admin_psychic_applications_path
      return
    elsif current_user.website_admin?
      redirect_to admin_dashboard_path
      return
    end
  end
end
