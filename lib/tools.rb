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

  def stop(binding)
    fork do
      sleep 2
      stop_sh 
    end
    redirect_to('/500', binding) 
  end
  
  def include_modules
    (E + LS).each do |l|
      include Kernel.const_get(IO.readlines(File.join(pwd, 'lib', [l, '.rb'].join))[0].split(S)[1])
    end
  end
  
  def header(binding) 
    response(binding)['content-type'] = 'text/html'
    erb('header', binding)
  end
  
  def footer
    erb('footer')
  end
  
  def tp(binding, &block)
    yield amount(binding), currency, plan(binding) 
  end
  
  def plan(binding)
    request(binding).request_uri.path.split(S5).last.to_i
  end
   
  def amount(binding)
    prices[plan(binding)]
  end
  
  def params(binding)
    request(binding).query
  end
 
  def param_blank?(k, binding)
    params(binding)[k].blank?
  end

  def params_invalid?(c, binding)
    c.any? { |k| param_blank?(k, binding) } 
  end
  
  def rip(binding)
    request(binding).remote_ip
  end

  def redirect_to(path, binding)
    url = ['https://', eget('WHOST'), path].join
    response(binding).status = 301
    response(binding).body = "<HTML><A HREF=\"#{url}\">#{url}</A>.</HTML>\n" 
    response(binding)['content-type'] = 'text/html'
    response(binding)['location'] = url
  end
 
  private
  
  def spm(c)
    c.split(S3).map(&:to_f)
  end
  
  def lfile(l)
    File.join('locales', [l, '.yml'].join)
  end
  
  def erb(t, binding = nil)
    ERB.new(File.read(File.join(views_path, [t, '.rhtml'].join))).result(binding)
  end
  
  def response(binding)
    binding.local_variable_get(:servlet_response)
  end
  
  def request(binding)
    binding.local_variable_get(:servlet_request)
  end
 
end
include Tools 
