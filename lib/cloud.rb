module Cloud
  
  def cloud(binding)
    i = i(binding)
    (i.nil? ? default_cloud : clouds[i]).to_sym
  end
  
  private

  def i(binding)
    countries.index(country(binding).downcase)
  end

end
include Cloud
