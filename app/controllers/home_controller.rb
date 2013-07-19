class HomeController < AuthorizedController
  def show
    if current_user.client?
      redirect_to client_path
      return
    elsif current_user.psychic?
      redirect_to psychic_path
      return
    end
  end
end
