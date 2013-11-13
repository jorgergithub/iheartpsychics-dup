class PsychicsController < AuthorizedController
  skip_before_filter :authenticate_user!, only: :new
  before_filter :find_psychic, except: [:new, :search, :about]

  attr_accessor :resource, :resource_name
  helper_method :resource, :resource_name

  def new
    @resource = User.new
    @resource_name = "user"
  end

  def edit
  end

  def show
  end

  def update
    if @psychic.localized.update_attributes(psychic_params)
      path = params[:redirect_to] || dashboard_path
      message = params[:redirect_message] || "Psychic was successfully updated."
      redirect_to path, notice: message
    else
      render action: "show"
    end
  end

  def search
    @client = current_client
    @psychics = Psychic.by_alias_name(params[:q])
  end

  def about
    @psychic = Psychic.find(params[:id])
  end

  def available
    @psychic.available!
    redirect_to dashboard_path, notice: "You're now available"
  end

  def unavailable
    @psychic.unavailable!
    redirect_to dashboard_path, notice: "You're now unavailable"
  end

  protected

  def find_psychic
    @psychic = current_psychic.localized
  end

  def psychic_params
    params.require(:psychic).permit(:phone, :ability_clairvoyance, :ability_clairaudient,
      :ability_clairsentient, :ability_empathy, :ability_medium, :ability_channeler,
      :ability_dream_analysis, :tools_tarot, :tools_oracle_cards, :tools_runes,
      :tools_crystals, :tools_pendulum, :tools_numerology, :tools_astrology,
      :specialties_love_and_relationships, :specialties_career_and_work,
      :specialties_money_and_finance, :specialties_lost_objects,
      :specialties_dream_interpretation, :specialties_pet_and_animals,
      :specialties_past_lives, :specialties_deceased, :style_compassionate,
      :style_inspirational, :style_straightforward, :about, :price,
      schedules_attributes: [:id, :date, :start_time_string, :end_time_string, :_destroy])
  end
end
