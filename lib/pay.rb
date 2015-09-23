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

  def pay(binding, &block)
    err(binding) do
      if pfailed?(binding)
        redirect_to(['/new/', p(binding)].join, binding)
      else
        yield address(binding), rcon, l(ltime(expires_at, binding))
      end
    end
  end

  private
  
  def payment_reason
    eget('PAYMENT_REASON')
  end
  
  def p(binding)
    params(binding)['plan'].to_i
  end
 
  def a(binding)
    prices[p(binding)]    
  end

  def amountc(binding)
    (a(binding).to_f * MU).to_i
  end
  
  def pfailed?(binding)
    params_invalid?(ALL, binding) || failed?(binding)
  end
  
  def saip_key
    eget([ST, ee.upcase, AK].join(S4))
  end

  def failed?(binding) 
    payment = pcreate(binding).dup
    payment.nil? || payment[:status] != SCS 
  end
  
  def card(binding)
    Hash[MAP.map{ |m| mpa(m, binding) }]
  end
  
  def mpa(a, binding)
    [a[0], params(binding)[a[1]]]
  end

  def stoken(binding)
    Stripe::Token.create(card: card(binding))
  end

  def pcreate(binding)
    Stripe.api_key = saip_key 
    c = Stripe::Charge.create(
      amount: amountc(binding),
      currency: currency,
      source: stoken(binding),
      description: payment_reason 
    )
    puts c.inspect
    c
  end 

end
include Pay
