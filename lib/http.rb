module Http

  OPTIONS = {
    DocumentRoot: File::dirname(__FILE__),
    Port: ENV.fetch('HTTP_PORT'),
    Host: ENV.fetch('WHOST'),
    BindAddress: ENV.fetch('BIND'),
    Logger: WEBrick::Log.new(ENV.fetch('OUTPUT'))
  }

  def http
    s = WEBrick::HTTPServer.new OPTIONS
    Routes::Http.routes(s)
    trap('INT') { s.stop }
    s
  end
end
include Http
