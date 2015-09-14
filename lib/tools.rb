module Tools 
  
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
    eget('HOST')
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
  
  def stop
    spawn(File.join(pwd, 'bin', 'stop'))    
    halt 500, slim(:error) 
  end
  
  def include_modules
    (E + LS).each do |l|
      include Kernel.const_get(IO.readlines(File.join(pwd, 'lib', [l, '.rb'].join))[0].split(' ')[1])
    end
  end

  private
  
  def spm(c)
    c.split(S3).map(&:to_f)
  end
  
  def lfile(l)
    File.join('locales', [l, '.yml'].join)
  end
  
end
include Tools 
