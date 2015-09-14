module Clouds::DC::Config
      
      def dc_access_token
        eget('DC_ACCESS_TOKEN')
      end

      def dc_size
        eget('DC_SIZE')
      end

      def dc_image_id
        eget('DC_IMAGE')
      end
      
      def dc_ssh_keys
        [eget('DC_SSH_KEY')]
      end
      
      def dc_coordinates
        decodec('DC_COORDINATES')
      end
      
      def dc_cities
        e('DC_CITIES')
      end
      
      def dck
        DropletKit::Client.new(access_token: dc_access_token)
      end

end
include Clouds::DC::Config
