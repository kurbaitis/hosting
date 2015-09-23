module Clouds::DC::City
      
  def dc_city(binding)
    dc_cities[min_distance_city(binding)]
  end
      
  private
      
  def distances(binding)
    dc_cities.each_index { |i| di(i, binding) }
  end
     
  def di(i, binding)
    distance(coordinates(binding), dc_coordinates[i])
  end

  def min_distance_city(binding)
    d = distances(binding)
    d.index(d.min)
  end

end
include Clouds::DC::City
