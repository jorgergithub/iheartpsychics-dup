require "ostruct"

class CallsController < ApplicationController
  protect_from_forgery :except => :notify
  before_action :identify_client
  helper_method :phone_number

  def index
    logger.info "Index for: #{incoming_number}"
    record_call
  end

  def user
    logger.info "Index for: #{incoming_number} -- #{params[:Digits]}"

    if params[:Digits] == "0"
      render :new_user
      return
    end

    unless params[:Digits].present? and params[:Digits].length == 10
      render :user_error
      return
    end

    @phone_number = "+1#{params[:Digits]}"
    @client_phone = ClientPhone.where(number: @phone_number).take
    if @client_phone
      @client = @client_phone.client
      record_call
      logger.info "Got client: #{@client.inspect}"
    else
      logger.info "No client."
      render :user_error
    end
  end

  def pin
    unless params[:Digits].present? and params[:Digits].length == 5
      render :pin_error
      return
    end

    unless @client and @client.valid_pin?(params[:Digits])
      logger.info "Pin error - client: #{@client.inspect} pin: #{@client.try(:valid_pin?, params[:Digits])}"
      render :pin_error
      return
    end

    logger.info "Pin valid - client: #{@client.inspect}"
    @psychic   = Psychic.first
    @caller_id = incoming_number || "+1-866-866-8288"
  end

  def notify
    logger.info "Params: #{params.inspect}"
    render nothing: true, status: :ok
  end

  def phone_number
    if @client_phone
      @client_phone.number
    elsif incoming_number
      incoming_number
    elsif digits = params[:Digits]
      digits = "+1#{digits}" unless digits =~ /^\+1/
      digits
    end
  end

  private

  def record_call
    @client.calls.create(sid: params[:CallSid]) if @client
  end

  def incoming_number
    number = params[:From] || params[:Caller]
    number = "+1#{number}" unless number =~ /^\+1/
    number
  end

  def identify_client
    logger.info "Trying to get client for: #{incoming_number}"
    @client_phone = ClientPhone.where(number: incoming_number).take
    logger.info "Client phone: #{@client_phone.inspect}"
    @client = @client_phone.client if @client_phone
    logger.info "Client: #{@client.inspect}"
  end
end
