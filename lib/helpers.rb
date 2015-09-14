module Helpers 
  
  def default_port
    eget('DEFAULT_PORT')
  end
  
  def currency
    eget('CURRENCY').upcase
  end
  
  def timeout_minutes
    eget('TIMEOUT').to_i / 60
  end
  
  def t(*args)
    I18n.t(*args)
  end

  def l(*args)
    I18n.l(*args)
  end
  
  def r(a)
    err { rs(a) }
  end
  
  def address
   [ip, default_port].join(S6)
  end

  def new(plan)
    [:new, plan].join(S5)
  end
  
  def ltime(time)
    tz = TZInfo::Timezone.get(timezone)
    tz.utc_to_local(time.utc)
  end
  
  def tu
    ['https://twitter.com/intent/tweet?url=', 'https://', whost, '/&text=', payment_reason].join
  end  
end
include Helpers
