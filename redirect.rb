require 'rubygems'
require 'webrick'

class Servlet < WEBrick::HTTPServlet::AbstractServlet
  HTTPS_HOST = ['https://', ENV.fetch('HOST'), ':', ENV.fetch('HTTPS_PORT')].join
  
  def do_GET(req, res)
    res.set_redirect(WEBrick::HTTPStatus::MovedPermanently, HTTPS_HOST)
  end
end

httpd = WEBrick::HTTPServer.new(
  DocumentRoot: File::dirname(__FILE__),
  Port: ENV.fetch('HTTP_PORT'),
  Host: ENV.fetch('HOST'),
  BindAddress: ENV.fetch('BIND'),
  ServerType: WEBrick::Daemon,
  Logger: WEBrick::Log.new(ENV.fetch('OUTPUT')),
  CGIPathEnv: ENV.fetch('PATH')
)

httpd.mount('/', Servlet)

trap(:INT){ httpd.shutdown }
httpd.start
