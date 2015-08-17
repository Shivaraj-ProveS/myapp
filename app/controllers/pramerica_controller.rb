require 'savon'

class PramericaController < ApplicationController

	skip_before_filter :verify_authenticity_token, only: [:policy_details]

    def load_wsdl
        
        soap_header = {
            "ns:authnHeader" => {
                "@soapenv:mustUnderstand" => 0,
                "@xmlns:ns" => "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd",
                "Username"  => "extuser",
                "Password"  => "extuser"
            }
        }
        
        client = Savon.client(wsdl: 'http://125.17.130.198/Cordys/EApp/getpolicydetailUAT.wsdl', wsse_auth: ["extuser", "extuser"])
        #client.wsse.credentials("extuser", "extuser") 
        Rails.logger.debug client.operations
        # response = client.call(:user_name_token, message: { username: 'extuser', password: 'extuser'})
        
        # Rails.logger.debug client.request(:get_policy_detail, )
        
        Rails.logger.debug client.request.to_s
        response = client.call(:get_policy_detail, message: { policy_no: '000000003'})
        Rails.logger.debug response.to_s
                
        render :json => 'ok'
    end
        
	def policy_details

		Rails.logger.debug params.to_s

		@policy_no = params["policy_no"]
		@user_name = params["user_name"]

                @success = true
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

                msg = { :success => @success, :user_name => @user_name, :policy_no => @policy_no, :plan_name => @plan_name, 
                    :policy_holder_name => @policy_holder_name, :premium_due_date => @premium_due_date, :premium_amount => @premium_amount, 
                    :service_tax => @service_tax, :total_premium => @total_premium, :interest_amount => @interest_amount, 
                    :clear_amount => @clear_amount, :amount_payable => @amount_payable, :payment_frequency => @payment_frequency
                }
        
                Rails.logger.debug msg.to_json
        
                render :json => msg.to_json, :content_type => 'application/json' 
	end

end