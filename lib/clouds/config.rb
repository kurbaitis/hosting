module Clouds::Config

  def clouds
    e('CLOUDS')
  end
  
  def countries
    e('COUNTRIES')
  end

  def default_cloud
    eget('DEFAULT_CLOUD')
  end
  
end
include Clouds::Config
