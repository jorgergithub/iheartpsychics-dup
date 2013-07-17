class ClientsController < AuthorizedController
  def show
    @client = current_user.client
  end
end
