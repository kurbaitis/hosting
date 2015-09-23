module Ip
  
  M = 24 * 60 * 60

  def ip(binding) 
    @ip = send(cloud(binding), binding)
  end
  
end
include Ip 
