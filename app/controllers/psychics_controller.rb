class PsychicsController < AuthorizedController
  skip_before_filter :authenticate_user!, only: [:new]
  before_filter :find_psychic, except: [:new]

  attr_accessor :resource, :resource_name
  helper_method :resource, :resource_name

  def new
    @resource = User.new
    @resource_name = "user"
  end

  def show
  end

  def update
    if @psychic.update_attributes(psychic_params)
      redirect_to dashboard_path, notice: "Psychic was successfully updated."
    else
      render action: "show"
    end
  end

  def search
    @psychics = Psychic.joins(:user).order("users.first_name, users.last_name").where(
      "CONCAT(users.first_name, ' ', users.last_name) LIKE ?", "%#{params[:q]}%")
  end

  protected

  def find_psychic
    @psychic = current_psychic
  end

  def psychic_params
    params.require(:psychic).permit(:phone)
  end
end
