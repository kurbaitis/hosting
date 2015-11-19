module Clouds::DC::Regions

  def dc_regions
    dck.images.find(id: dc_image_id).regions
  end

end
include Clouds::DC::Regions
