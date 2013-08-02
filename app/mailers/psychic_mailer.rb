class PsychicMailer < ActionMailer::Base
  default from: "noreply@iheartpsychic.co"

  def confirmation_email(psychic)
    @psychic = psychic
    mail(to: psychic.email, subject: "Application to I Heart Psychic was received")
  end

  def approved_email(psychic)
    @psychic = psychic
    mail(to: psychic.email, subject: "Your application to I Heart Psychic was approved")
  end

  def declined_email(psychic)
    @psychic = psychic
    mail(to: psychic.email, subject: "Your application to I Heart Psychic was declined")
  end
end
