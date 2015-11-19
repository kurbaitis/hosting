module Clouds::DC::City
      
  def dc_city
    dc_cities[min_distance_city]
  end
      
  private
      
  def distances
    dc_cities.each_index { |i| di(i) }
  end
     
  def di(i, binding)
    distance(coordinates, dc_coordinates[i])
  end

  def min_distance_city
    d = distances
    d.index(d.min)
  end

end
include Clouds::DC::City
