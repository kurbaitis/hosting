module Ip
  
  M = 24 * 60 * 60

  def ip 
    @ip = send(cloud)
  end
  
end
include Ip 
