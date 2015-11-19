$: << File.dirname(File.realpath(__FILE__))
E = %w(err)
H = %w(helpers)
LS = %w(twilio twilio/m geo clouds/dc clouds/dc/config clouds/dc/regions clouds/dc/city clouds/dc/region clouds/config cloud plans pay details ip http routes/http routes geof)
ALL = (E + H + LS).map{ |a| File.join('lib', a) }
require 'rubygems'
require 'lib/tools'
gems.each(&method(:require))
ALL.each(&method(:require))

I18n.available_locales = available_locales 
I18n.load_path = locales_load_path
L = WEBrick::Log::new(output, WEBrick::Log::DEBUG)

fork { geof }
fork { http.start }
