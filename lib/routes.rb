module Routes
  
  RootPath = S5 
  NewPath = '/new'
  CreatePath = [NewPath, 'create'].join(S5)
  E500Path = '/500'

  def new_plan_path(p)
    [NewPath, p].join(S5)
  end  
  
end
include Routes
