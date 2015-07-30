class PramericaController < ApplicationController

	skip_before_filter :verify_authenticity_token, only: [:policy_details]

	def policy_details

		Rails.logger.debug params.to_s

		@policy_no = params["policy_no"]
		@user_name = params["user_name"]


        @plan_name = "Pramerica 101"
        @policy_holder_name = "Holder 123"
        @premium_due_date = "12/08/2015"
        @premium_amount = "2000"
        @service_tax = "20"
        @total_premium = "2020"
        @interest_amount = "10"
        @clear_amount = "30"
        @amount_payable = "2060"
        @policy_status = "active"
        @payment_frequency = "monthly"

        msg = { :status => "ok", :plan_name => @plan_name, :policy_holder_name => @policy_holder_name, 
                :premium_due_date => @premium_due_date, :premium_amount => @premium_amount, :service_tax => @service_tax,
                :total_premium => @total_premium, :interest_amount => @interest_amount, :clear_amount => @clear_amount,
                :amount_payable => @amount_payable, :payment_frequency => @payment_frequency
        }
        
        Rails.logger.debug msg.to_json
        
        render :json => msg.to_json, :content_type => 'application/json' 
	end

end