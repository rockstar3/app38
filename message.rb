class Message < ActiveRecord::Base
  # attr_accessible :title, :body
  def self.send(from_phone, to_phone, msg, callback_url)
    begin
      @client = Twilio::REST::Client.new(TWILIO_SID, TWILIO_TOKEN)
      if from_phone == ""
        from_phone = TWILIO_MANAGE_NUMBER
      end
      msg_obj = @client.account.sms.messages.create(
        :from => from_phone,
        :to => to_phone,
        :body => msg,
        :status_callback => callback_url
      )
      return true
    rescue Twilio::REST::RequestError => e      
      return false
    end
    
  end

end

