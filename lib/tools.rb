module Tools 

  S = ' '  
  S1 = '.'
  S2 = '|'
  S3 = ','
  S4 = '_'
  S5 = '/'
  S6 = ':'
  S7 = ': ' 
  N = "\n" 
  TRUE = 'true'
  MCS = Regexp.new(LS.map { |l| ['(', File.join(ENV.fetch('PWD'), 'lib', l), ')'].join }.join(S2))
  Y = '*.yml'
  
  def eget(k)
    ENV.fetch(k)
  end
  
  def e(k, s = S1)
    eget(k).split(s)
  end
  
  def egets(k)
    eget(k).to_sym
  end

  def decodec(k)
    e(k, S2).map(&method(:spm))
  end
  
  def ee
    eget('ENVIRONMENT')
  end

  def whost 
    eget('WHOST')
  end
  
  def wbind 
    eget('BIND')
  end
  
  def https_port 
    eget('HTTPS_PORT')
  end
  
  def ssl?
    eget('FORCE_SSL') == TRUE
  end
  
  def ssl_key_path
    eget('SSL_PKEY_PATH')
  end
  
  def ssl_cert_path
    eget('SSL_CERT_PATH')
  end
  
  def output
    eget('OUTPUT')
  end
  
  def locales_load_path
    Dir[File.join(eget('LD'), Y)]
  end	
  
  def views_path
    eget('V')
  end

  def gems
    e('G')
  end
 
  def tel
    eget('TEL')
  end
  
  def pwd
    eget('PWD')
  end
  
  def rs(a)
    slim a, layout: :application
  end
  
  def stop_sh
    spawn(File.join(pwd, 'bin', 'stop'))
  end

  def stop
    fork do
      sleep 2
      stop_sh 
    end
    redirect_to('/500') 
  end
  
  def include_modules
    (E + LS).each do |l|
      include Kernel.const_get(IO.readlines(File.join(pwd, 'lib', [l, '.rb'].join))[0].split(S)[1])
    end
  end
  
  def b
   @b
  end

  def header(binding) 
    @b = binding
    response['content-type'] = 'text/html'
    erb('header')
  end
  
  def footer
    GC.start
    erb('footer')
  end
  
  def tp(&block)
    yield amount, currency, plan
  end
  
  def plan
    request.request_uri.path.split(S5).last.to_i
  end
   
  def amount
    prices[plan]
  end
  
  def params
    request.query
  end
 
  def param_blank?(k)
    params[k].blank?
  end

  def params_invalid?(c)
    c.any? { |k| param_blank?(k) } 
  end
  
  def rip
    request.remote_ip
  end

  def redirect_to(path)
    GC.start
    url = ['https://', eget('WHOST'), path].join
    response.status = 301
    response.body = "<HTML><A HREF=\"#{url}\">#{url}</A>.</HTML>\n" 
    response['content-type'] = 'text/html'
    response['location'] = url
  end
 
  private
  
  def spm(c)
    c.split(S3).map(&:to_f)
  end
  
  def lfile(l)
    File.join('locales', [l, '.yml'].join)
  end
  
  def erb(t)
    ERB.new(File.read(File.join(views_path, [t, '.rhtml'].join))).result(binding)
  end
  
  def response
    b.local_variable_get(:servlet_response)
  end
  
  def request
    b.local_variable_get(:servlet_request)
  end
 
end
include Tools 
