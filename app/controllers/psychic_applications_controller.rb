class PsychicApplicationsController < ApplicationController
  layout "login"

  def new
    @psychic_application = PsychicApplication.new
  end
end
