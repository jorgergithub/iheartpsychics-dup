class SurveysController < AuthorizedController
  def show
    @call = Call.find(params[:id])
    @survey = Survey.active
    @call_survey = @call.build_call_survey(survey: @survey)
    @call_survey.build_answers
  end

  def answer
    @call = Call.find(params[:id])
    @survey = Survey.active
    @call_survey = @call.build_call_survey(survey: @survey)

    answers_params[:answers].each_pair do |id, answer|
      params = answer.merge(question_id: id)
      @call_survey.answers.build(params)
    end

    if @call_survey.save
      redirect_to client_path, notice: "Your survey results were saved successfully."
    else
    end
  end

  protected

  def answers_params
    params.require(:call_survey).permit(answers: [:option_id, :text])
  end
end
