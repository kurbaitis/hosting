module Clouds::DC::City
      
      def dc_city
        dc_cities[min_distance_city]
      end
      
      private
      
      def distances
        dc_cities.each_index(&method(:di))
      end
      
      def di(i)
        distance(coordinates, dc_coordinates[i])
      end

      def min_distance_city
        distances.index(distances.min)
      end

end
include Clouds::DC::City
