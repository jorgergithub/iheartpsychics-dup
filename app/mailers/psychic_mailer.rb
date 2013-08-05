class PsychicMailer < ActionMailer::Base
  default from: "noreply@iheartpsychics.co"

  def confirmation_email(psychic)
    @psychic = psychic
    mail(to: psychic.email, subject: "Application to I Heart Psychics was received")
  end

  def approved_email(psychic, psychic_application)
    @psychic = psychic
    @psychic_application = psychic_application
    mail(to: psychic.email, subject: "Your application to I Heart Psychics was approved")
  end

  def declined_email(psychic)
    @psychic = psychic
    mail(to: psychic.email, subject: "Your application to I Heart Psychics was declined")
  end
end
