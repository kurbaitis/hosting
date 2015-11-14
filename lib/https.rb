module Https

  SSL_OPTIONS = {
    SSLCACertificateFile: ENV.fetch('SSL_CA_CERT_PATH'),
    SSLCertificate: OpenSSL::X509::Certificate.new(File.read(ENV.fetch('SSL_CERT_PATH'))),
    SSLPrivateKey: OpenSSL::PKey::RSA.new(File.read(ENV.fetch('SSL_PKEY_PATH'))),
    SSLVerifyClient: OpenSSL::SSL::VERIFY_PEER,
    SSLOptions: 0 
  }

  OPTIONS = {
    Port: ENV.fetch('HTTPS_PORT'),
    ServerName: 'https',
    BindAddress: ENV.fetch('WHOST'),
    DocumentRoot: "./public",
    SSLEnable: true,
    MimeTypes: { 'html' => 'text/html' }
  }.merge(SSL_OPTIONS)

  WEBrick::GenericServer.class_eval do
    def ssl_context
      return @ssl_context if @ssl_context
      ctx = setup_ssl_context(SSL_OPTIONS)
      ctx.ssl_version = ENV.fetch('SSL_VERSION')
      ctx.ciphers = ENV.fetch('SSL_CIPHERS')
      @ssl_context = ctx
    end
  end

  def https
    s  = WEBrick::HTTPServer.new OPTIONS.merge(Logger: L)
    Routes::Https.routes(s)
    trap('INT') { s.stop }
    s
  end

end
include Https
