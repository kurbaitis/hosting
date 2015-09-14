module Err
  
  SR = Regexp.new(pwd)
  E = /(Exception)|(Error)/

  def err(&block)
    yield
  rescue *err_classes => e
    sb(e)
    stop
  end

  private
  
  def m
    egets('ERROR_REPORTER')
  end
  
  def err_classes
    return [NilClass] if m.blank?
    cs = []
    ObjectSpace.each_object(Class) {|c| cs << c if c.name.to_s.match(E) }
    cs
  end
  
  def srmatch(b)
    b.match(MCS) 
  end
  
  def sb(e)
    L.debug e.inspect
    L.debug e.backtrace.inspect
    send(m, e.backtrace.select(&method(:srmatch))[0].to_s)
  end
  
end
include Err
