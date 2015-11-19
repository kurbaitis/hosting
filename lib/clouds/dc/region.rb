module Clouds::DC::Region
      
  R1 = '^'
  R2 = '\d+$'

  def dc_region
    dc_regions.find { |r| match(r) }
  end
      
  private
      
  def rx
    Regexp.new([R1, dc_city, R2].join)
  end

  def match(s)
    s.match(rx)
  end

end
include Clouds::DC::Region
