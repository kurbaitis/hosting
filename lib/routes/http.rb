module Routes
  module Http
    
    T = 'http.rhtml'
    
    def self.routes(s)
      s.mount RootPath, WEBrick::HTTPServlet::ERBHandler, File.join(views_path, T)
    end

  end
end
