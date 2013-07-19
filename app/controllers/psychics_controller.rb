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

  def search
    @psychics = Psychic.joins(:user).order("users.first_name, users.last_name").where(
      "CONCAT(users.first_name, ' ', users.last_name) LIKE ?", "%#{params[:q]}%")
  end

  protected

  def find_psychic
    @psychic = current_psychic
  end
end
