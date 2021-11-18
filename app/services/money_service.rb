class MoneyService

	class Error < StandardError
    attr_accessor :error_code, :error_status, :error_message

    def initialize(error_code: nil,error_status: nil, error_message: nil)
      @error_code = error_code
      @error_status = error_status
      @error_message = error_message
      super
    end
  end

  attr_accessor :params, :receiver, :sender
  def initialize(params: {},sender:)
    @params = params
    @sender = sender
    @receiver = find_receiver
  end

  def deposit
  	validate_receiver
  	validate_amount

  	receiver.add_balance(params['amount'])
  	sender.decreament_balance(params['amount'])

  	sender
  end

  def find_receiver
  	Account.find_by('email =? OR phone_number =?',
  									params["email"],params["phone_number"])
  end

  private
  def validate_receiver
  	raise_error("Receiver not found", 404, 404) unless receiver

  	raise_error("Unverified Receiver can't Receive Money", 
  							403, 403) unless receiver.verified_status?
  end

  def validate_amount
  	raise_error("Less Current Amount",
  							302,302) if sender.low_amount?(params['amount'])
  end

  def raise_error(error_message, error_code, error_status)
    raise Error.new(error_message: error_message, 
    								error_code: error_code, error_status: error_status)
  end
end
