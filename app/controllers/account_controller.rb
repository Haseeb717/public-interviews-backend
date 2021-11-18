class AccountController < ApplicationController
	before_action :authenticate_account!
	before_action :validate_account!, only: %i[send_money]

	def send_money
		begin
			account = MoneyService.new(params: params.to_enum.to_h,
																	sender: current_account).deposit
			return render json: account, status: 200
		rescue MoneyService::Error => error
			return render json: { code: error.error_code,
				message: error.error_message}, status: 200
		end
	end

	def history
		histories = current_account.histories.as_json
		return render json: histories, status: 200
	end

	private
	def validate_account!
		render_error_unverified_account unless current_account.verified_status?
	end

	def render_error_unverified_account
    json_response({errors:
      "Non Verified Account can't Send Money"}, 401)
  end
end
