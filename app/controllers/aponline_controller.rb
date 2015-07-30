class AponlineController < ApplicationController

	skip_before_filter :verify_authenticity_token, only: [:txn_callback]

	@@txn_status = ''
	@@count = 0
	@@ref_info = ''
	@@status_info = ''
	@@amount = ''
	@@device_id = ''
	@@pmt_status = ''
	@@card_type = ''
	@@card_brand = ''
	@@payer_name = ''
	@@auth_code = ''

	def index
		@ref_info = ''
		@status_info = ''
		@txn_status = @@txn_status = 'Ready'
	end
	
	def card_pay
		@ref_info = @@ref_info = rand(36**8).to_s(36)
		@status_info = @@status_info = 'Processing your card transaction'
		@txn_status = @@txn_status = 'In Process'

		Rails.logger.debug "cont_txn_status="+@txn_status.to_s
    respond_to do |format|
      format.js
    end
	end

	def check_status
		@txn_status = @@txn_status
		@status_info = @@status_info
		@ref_info = @@ref_info
    respond_to do |format|
      format.js
    end
	end

	def complete
		@ref_info = @@ref_info
		@status_info = "Your payment was processed. < Status: #{@@pmt_status} Amt: Rs. #{@@amount.to_s}"
		@status_info << " Card: #{@@card_type}/#{@@card_brand} Device: #{@@device_id}>"
		@txn_status = @@txn_status
		@complete = true
    respond_to do |format|
      format.js
    end
	end

	def update_status
		@@txn_status = 'Complete'
		@@pmt_status = params[:pmt_status]
		@@amount = params[:amount]
		@@device_id = params[:device_id]

		render :nothing => true
	end

	def txn_callback

		@status = params["status"]
		Rails.logger.debug params.to_s

		@@txn_status = 'Complete'
		@@pmt_status = params['status']
		@@amount = params['amount']
		@@device_id = params['deviceSerial']
		@@card_type = params['paymentCardType']
		@@card_brand = params['paymentCardBrand']
		@@payer_name = params['payerName']
		@@auth_code = params['authCode']

    render :json => 'ok'
	end

end