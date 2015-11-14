module Cloud
  
  def cloud
    (i.nil? ? default_cloud : clouds[i]).to_sym
  end
  
  private

  def i
    countries.index(country.downcase)
  end

end
include Cloud
