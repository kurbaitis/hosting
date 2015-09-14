$: << File.dirname(File.realpath(__FILE__))
E = %w(err)
H = %w(helpers)
LS = %w(twilio twilio/m geo clouds/dc clouds/dc/config clouds/dc/regions clouds/dc/city clouds/dc/region clouds/config cloud plans pay ip) 
ALL = (E + H + LS).map{ |a| File.join('lib', a) }
require 'rubygems'
require 'lib/tools'
gems.each(&method(:require))
ALL.each(&method(:require))

I18n.available_locales = available_locales 
I18n.load_path = locales_load_path
L = WEBrick::Log::new(output, WEBrick::Log::DEBUG)

class Hosting < Sinatra::Base
  include_modules
  set :views, views_path 
  
  error do
    stop
  end

  before do
    I18n.locale = locale
  end

  helpers do
    require_relative 'lib/helpers'
  end

  get('/') { r(:index) }
  get('/new/:plan') { r(:new) }
  post('/new/create') { pay }
end

app = Rack::Builder.new do 
  map '/' do
    run Hosting 
  end
end

webrick_options = {
  ServerType: WEBrick::Daemon,
  Port: https_port,
  Host: whost,
  BindAddress: wbind,
  Logger: L,
  DocumentRoot: "./public",
  SSLEnable: true,
  SSLCertificate: OpenSSL::X509::Certificate.new(File.open(ssl_cert_path).read),
  SSLPrivateKey: OpenSSL::PKey::RSA.new(File.open(ssl_key_path).read),
  SSLCertName: [ [ "CN",WEBrick::Utils::getservername ] ]
}

Rack::Handler::WEBrick.run app, webrick_options
