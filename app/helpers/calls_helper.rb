module CallsHelper
  def calls_url_for(action, number)
    "/calls/#{action}.xml?From=#{CGI.escape(number)}"
  end
end
