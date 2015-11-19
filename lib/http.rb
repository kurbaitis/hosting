module Http
  
  OPTIONS = {
    Port: ENV.fetch('HTTP_PORT'),
    ServerName: 'https',
    BindAddress: ENV.fetch('BIND'),
    DocumentRoot: "./public",
    SSLEnable: false,
    MimeTypes: { 'html' => 'text/html' }
  }

  def http
    s  = WEBrick::HTTPServer.new OPTIONS.merge(Logger: L)
    Routes::Http.routes(s)
    trap('INT') { s.stop }
    s
  end

end
include Http
