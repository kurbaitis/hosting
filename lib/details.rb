module Details

  def numplayers(binding)
    players[plan(binding)]
  end
  
  def rcon
    @rcon ||= rnumber
  end

  def rnumber
    Random.new.seed.to_s[1..11]
  end
   
  def user_data_a(binding)
    { numplayers: numplayers(binding), rcon: rcon, expires_at: expires_at }.to_a
  end

  def user_data(binding)
    user_data_a(binding).map(&method(:jd)).join(N)
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
include Details
