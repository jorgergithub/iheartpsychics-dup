class CallSurvey < ActiveRecord::Base
  belongs_to :call
  belongs_to :survey
  has_many :answers, dependent: :destroy

  def build_answers
    survey.questions.each_with_index do |q, i|
      answers.build(id: i, question: q)
    end
  end
end
