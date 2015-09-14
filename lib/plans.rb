module Plans  

  def players
    e('PLAYERS')
  end

  def prices
    e('PRICES')
  end
  
  def mp
    players.first
  end  
  
  def plans
    players.map.with_index(&method(:bplan))
  end
  
  private

  def bplan(n, i)
    [n, prices[i]]
  end

end
include Plans
