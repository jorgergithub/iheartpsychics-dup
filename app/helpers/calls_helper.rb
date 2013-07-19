module CallsHelper
  def calls_url_for(action, number, psychic=nil)
    psychic_qs = "&psychic_id=#{psychic.id}" if psychic

    "/calls/#{action}.xml?From=#{CGI.escape(number)}#{psychic_qs}"
  end
end
