class CallSurveyMailer < ActionMailer::Base
  default from: "noreply@iheartpsychics.co"

  def notify_manager_director(user, call_survey, review)
    @user = user
    @call_survey = call_survey
    @review = review
    @call = @call_survey.call
    @client = @call.client
    @psychic = @call.psychic
    mail(to: user.email, subject: "New I Heart Psychics survey response")
  end
end
