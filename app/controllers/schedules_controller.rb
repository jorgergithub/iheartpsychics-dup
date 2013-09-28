class SchedulesController < AuthorizedController
  def index
    @psychic = current_psychic
    @schedules = current_psychic.next_week_schedules_by_date
  end
end
