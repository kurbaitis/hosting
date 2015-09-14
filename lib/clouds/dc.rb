module Clouds
  module DC
    
    GS = 'active'

    def dc
      sip(dck.droplets.create(droplet))
    end
    
    private
    
    def droplet
      DropletKit::Droplet.new(args)
    end

    def args
      {
        name: number,
        region: dc_region,
        size: dc_size,
        image: dc_image_id,
        ssh_keys: dc_ssh_keys,
        backups: false,
        ipv6: false,
        user_data: user_data,
        private_networking: nil
      }
    end

    def sip(s)
      s = dck.droplets.find(id: s.id)

      if s.status != GS 
        sleep 10
        return sip(s)
      end

      s.public_ip
    end

  end
end
include Clouds::DC
