class SurveysController < AuthorizedController
  def show
    @call = Call.find(params[:id])
    @survey = Survey.active
    @call_survey = @call.build_call_survey(survey: @survey)
    @call_survey.build_answers
    @review = current_client.reviews.build(psychic: @call.psychic)
  end

  def answer
    @call = Call.find(params[:id])
    @survey = Survey.active
    @call_survey = @call.build_call_survey(survey: @survey)

    survey_params[:answers].each_pair do |id, answer|
      params = answer.merge(question_id: id)
      @call_survey.answers.build(params)
    end

    @review = current_client.reviews.build(review_params.merge(psychic: @call.psychic))
    ActiveRecord::Base.transaction do
      if @call_survey.save and @review.save
        CallSurveyMailer.notify_manager_director(ManagerDirector.first, @call_survey, @review).deliver
        redirect_to client_path, notice: "Your survey results were saved successfully."
      else
      end
    end
  end

  protected

  def survey_params
    params.require(:call_survey).permit(answers: [:option_id, :text])
  end

  def review_params
    params.require(:review).permit(:rating, :text)
  end
end
