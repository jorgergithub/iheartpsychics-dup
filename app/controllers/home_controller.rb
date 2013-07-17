class HomeController < AuthorizedController
  def show
    if current_user.client?
      redirect_to clients_path
      return
    end
  end
end
