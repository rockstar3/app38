
class SmsController < ApplicationController
  before_filter :authenticate_user
  def update_queue
    
  end
  def twilio_callback
    @customer_id = params[:customer]
    @user_id = params[:user]
    message_sid = params[:SmsSid]
    status = params[:SmsStatus]
    sms_message_sid = params[:SmsMessageSid]   
         
    # Update message status in queues table
    @queues = Queues.where('message_sid=? and user_id=?', message_sid, @user_id)
    if @queues.nil? or @queues.blank?
      @queues = Queues.new
      @save_data = { 
        :user_id => @user_id,
        :customer_id => @customer_id,
        :message_sid => message_sid,
        :SmsMessageSid => sms_message_sid,
        :status => status
      }
      @queues.update_attributes(@save_data);      
    else
      @queue.update_attributes({ 
        :status => status,
        :SmsMessageSid => sms_message_sid          
      })
    end
    
    # Set opt-out if customer doesn't want offer    
    message = sms_get_message(sms_message_sid)
    if message.body.include? "2"
      phone = message.from
      @customer = Customer.update_all({:opt_out => '1'}, {:phone => phone})
    end      
  end

  def show_messages
    #@queues = Queues.find(:condition => ["user_id" => current_user.id])
    client = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token'])

    @queues = Queues.where(' user_id = ?', current_user.id)
    
    @message_ary = []
    if @queues.empty?
      @queues = []
    end
    @queues.each do |queue|
      client.account.sms.messages.list.each do |message|
        if message.sid ==  queue.message_sid
          @message_ary << message
          break      
        end 
      end
    end
  end  
end
