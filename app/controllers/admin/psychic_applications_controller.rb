class Admin::PsychicApplicationsController < AuthorizedController
  before_filter :find_psychic_application

  def index
    @psychic_applications = PsychicApplication.pending
  end

  def show
  end

  def update
    if params[:commit] == "Approve"
      @psychic_application.approve!
      redirect_to admin_psychic_applications_path,
        notice: "Psychic approved successfully."
    end
  end

  protected

  def find_psychic_application
    @psychic_application = PsychicApplication.find(params[:id]) if params[:id]
  end
end
