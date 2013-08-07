class CallSurvey < ActiveRecord::Base
  belongs_to :call
  belongs_to :survey
end
