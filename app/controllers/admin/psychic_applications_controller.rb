class Admin::PsychicApplicationsController < AuthorizedController
  def index
    @psychic_applications = PsychicApplication.pending
  end
end
