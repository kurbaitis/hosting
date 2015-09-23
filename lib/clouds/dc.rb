module Clouds
  module DC
    
    GS = 'active'

    def dc(binding)
      sip(dck.droplets.create(droplet(binding)))
    end
    
    private
    
    def droplet(binding)
      DropletKit::Droplet.new(args(binding))
    end

    def args(binding)
      {
        name: rnumber,
        region: dc_region(binding),
        size: dc_size,
        image: dc_image_id,
        ssh_keys: dc_ssh_keys,
        backups: false,
        ipv6: false,
        user_data: user_data(binding),
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
