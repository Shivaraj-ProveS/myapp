class PaymentsController < ApplicationController
	@@txn_status = ''
	@@count = 0
	@@ref_info = ''
	@@status_info = ''
	@@amount = ''
	@@merchant_id = ''
	@@pmt_status = ''

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
		@status_info = "Your payment was processed. Merchant Id: " + @@merchant_id + " Amount: " + @@amount + " Status: " + @@pmt_status
		@txn_status = @@txn_status
    respond_to do |format|
      format.js
    end
	end

	def update_status
		@@txn_status = 'Complete'
		@@pmt_status = params[:pmt_status]
		@@amount = params[:amount]
		@@merchant_id = params[:merchant_id]

		render :nothing => true
	end

end