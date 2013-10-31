class CallScript < ActiveRecord::Base
  attr_accessor :context
  serialize :params

  def self.process(call_sid, context)
    self.where(call_sid: call_sid).first_or_initialize.process(context)
  end

  def context=(c)
    @context = OpenStruct.new(
      digits: c.params[:Digits],
      params: c.params
    )
  end

  def process(context)
    self.context = context
    self.next_action ||= "initial_state"
    response = send(self.next_action)
    save

    return response
  end

  def send_menu(greet, options)
    self.next_action = "process_menu_result"
    self.params = {menu_options: options}

    num_digits = options.keys.group_by(&:length).max.first
    gather_options = if num_digits > 1
      options = { finishOnKey: "#" }
    else
      options = { numDigits: num_digits }
    end

    Twilio::TwiML::Response.new do |r|
      r.Gather(gather_options) { |g| g.Say greet }
    end.text
  end

  def process_menu_result
    action = self.params[:menu_options][context.digits.to_s]

    unless action
      response = Twilio::TwiML::Response.new do |r|
        options = self.params[:menu_options].keys
        r.Say <<-EOS
          The option you selected is invalid.
          Please enter #{options.to_sentence(two_words_connector: " or ", last_word_connector: " or ")}.
        EOS
      end
      return response.text
    end

    self.next_action = action
    self.process(self.context)
  end

  def send_to_conference(conference)
    Twilio::TwiML::Response.new do |r|
      r.Dial do |d|
        d.Conference conference
      end
    end.text
  end
end
