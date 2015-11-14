module Pay
  
  SCS = 'succeeded'
  ST = 'STRIPE'
  AK = 'API_KEY'
  MU = 100
  MAP = {
    number: 'number',
    exp_month: 'month',
    exp_year: 'year',
    cvc: 'cvc'
  }
  ALL = MAP.values

  def pay(&block)
    err do
      if pfailed?
        redirect_to(['/new/', p].join)
      else
        yield '127.0.0.1', '12312312312', l(ltime(expires_at))
      end
    end
  end

  private
  
  def payment_reason
    eget('PAYMENT_REASON')
  end
  
  def p
    params['plan'].to_i
  end
 
  def a
    prices[p]    
  end

  def amountc
    (a.to_f * MU).to_i
  end
  
  def pfailed?
    params_invalid?(ALL) || failed?
  end
  
  def saip_key
    eget([ST, ee.upcase, AK].join(S4))
  end

  def failed? 
    payment = pcreate.dup
    payment.nil? || payment[:status] != SCS 
  end
  
  def card
    Hash[MAP.map{ |m| mpa(m) }]
  end
  
  def mpa(a)
    [a[0], params[a[1]]]
  end

  def stoken
    Stripe::Token.create(card: card)
  end

  def pcreate
    Stripe.api_key = saip_key 
    c = Stripe::Charge.create(
      amount: amountc,
      currency: currency,
      source: stoken,
      description: payment_reason 
    )
    puts c.inspect
    c
  end 

end
include Pay
