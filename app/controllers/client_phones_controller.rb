class ClientPhonesController < AuthorizedController
  def new
  end

  def update
    render text: params
  end
end
