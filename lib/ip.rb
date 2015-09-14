module Ip
  
  M = 24 * 60 * 60

  def ip    
    @ip = send(cloud)
  end
  
  private
  
  def numplayers
    players[plan]
  end
  
  def rcon
    @rcon ||= number
  end

  def number
    Random.new.seed.to_s[1..11]
  end
   
  def user_data_a
    { numplayers: numplayers, rcon: rcon, expires_at: expires_at }.to_a
  end

  def user_data
    user_data_a.map(&method(:jd)).join(N)
  end
  
  def expires_at
    @expires_at ||= Time.now + expire_days * M 
  end

  def expire_days
    eget('EXPIRE_DAYS').to_i  
  end
  
  def jd(e)
    e.join(S7)
  end

end
include Ip 
