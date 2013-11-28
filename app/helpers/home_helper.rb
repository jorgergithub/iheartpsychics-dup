module HomeHelper
  def container_offer_class
    return "modal_link" if @client
    return "sign_up_link" unless current_user
  end
end