module Routes
  module Http
    
    I = 'index.rhtml'
    N = 'new.rhtml'
    C = 'create.rhtml'
    R5 = '500.rhtml'

    def self.routes(s)
      s.mount RootPath, WEBrick::HTTPServlet::ERBHandler, File.join(views_path, I)
      plans.each_index do |i|
        s.mount new_plan_path(i), WEBrick::HTTPServlet::ERBHandler, File.join(views_path, N)
      end
      s.mount CreatePath, WEBrick::HTTPServlet::ERBHandler, File.join(views_path, C)
      s.mount E500Path, WEBrick::HTTPServlet::ERBHandler, File.join(views_path, R5)
    end
  
  end
end
