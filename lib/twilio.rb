module Twilio
  
  def twilio
    Twilio::REST::Client.new(t_account_sid, t_auth_token)
  end

  private
  
  def t_account_sid
    eget('T_ACCOUNT_SID')
  end
  
  def t_auth_token
    eget('T_AUTH_TOKEN')
  end

end
include Twilio
