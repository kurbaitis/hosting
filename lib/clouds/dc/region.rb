module Clouds::DC::Region
      
  R1 = '^'
  R2 = '\d+$'

  def dc_region(binding)
    dc_regions.find { |r| match(r, binding) }
  end
      
  private
      
  def rx(binding)
    Regexp.new([R1, dc_city(binding), R2].join)
  end

  def match(s, binding)
    s.match(rx(binding))
  end

end
include Clouds::DC::Region
