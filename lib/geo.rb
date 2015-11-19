module Geo
  
  LR = /[a-z]{2}/  
  
  def country 
    geo.country.iso_code 
  end
  
  def timezone
    geo.location.time_zone
  end
    
  def locale
    available_locales.include?(lr) ? lr : available_locales.first
  end
  
  def lr
    hal.present? ? hal.to_s.match(LR)[0] : nil
  end
  
  def coordinates
    l = geo.location
    [l.latitude, l.longitude] 
  end
  
  def hal
    env['HTTP_ACCEPT_LANGUAGE']
  end

  def distance(l1, l2)
    rad_per_deg = Math::PI/180
    rkm = 6371
    rm = rkm * 1000

    dlat_rad = (l2[0]-l1[0]) * rad_per_deg
    dlon_rad = (l2[1]-l1[1]) * rad_per_deg

    lat1_rad, lon1_rad = l1.map {|i| i * rad_per_deg }
    lat2_rad, lon2_rad = l2.map {|i| i * rad_per_deg }

    a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

    rm * c
  end
  
  private
  
  def available_locales
    e('AVAILABLE_LOCALES')
  end
  
  def dat
    eget('GEO_DB')
  end

  def geo
    MaxMindDB.new(dat).lookup(rip)
  end

end
include Geo
