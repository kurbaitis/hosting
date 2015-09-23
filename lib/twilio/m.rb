module Twilio::M
    
  def tm(m)
    twilio.account.messages.create(
      from: t_from,
      to: tel,
      body: m 
    )
  end
    
  private

  def t_from
    eget('T_FROM')
  end

end
include Twilio::M
