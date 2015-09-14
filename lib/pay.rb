module Pay
  
  SCS = 'succeeded'
  ST = 'STRIPE'
  AK = 'API_KEY'
  MU = 100
  MAP = {
    number: :number,
    exp_month: :month,
    exp_year: :year,
    cvc: :cvc
  }
  ALL = MAP.values

  def pay
    err do
      validate!
      rs(:create)
    end
  end

  private
  
  def payment_reason
    eget('PAYMENT_REASON')
  end

  def amount
    prices[plan]
  end
  
  def amountc
    (amount.to_f * MU).to_i
  end
  
  def paramsm(k)
    params[k]
  end

  def plan
    params[:plan].to_i
  end
  
  def validate!
    params_invalid? || failed?
  end
  
  def param_blank?(key)
    params[key].blank?
  end

  def params_invalid?
    ALL.any?(&method(:param_blank?))
  end
  
  def saip_key
    eget([ST, ee.upcase, AK].join(S4))
  end

  def failed? 
    payment = pcreate.dup
    payment.nil? || payment[:status] != SCS 
  end
  
  def card
    Hash[MAP.map(&method(:mpa))]
  end
  
  def mpa(a)
    [a[0], params[a[1]]]
  end

  def stoken
    Stripe::Token.create(card: card)
  end

  def pcreate
    Stripe.api_key = saip_key 
    Stripe::Charge.create(
      amount: amountc,
      currency: currency,
      source: stoken,
      description: payment_reason 
    )
  end 

end
include Pay
