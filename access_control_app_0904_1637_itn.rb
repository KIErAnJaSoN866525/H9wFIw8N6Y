# 代码生成时间: 2025-09-04 16:37:26
# 使用SINATRA框架创建一个简单的访问权限控制应用
class AccessControlApp < Sinatra::Base

  # 设置一个全局变量来存储用户信息
  @@users = {}

  # 注册路由
  get '/register' do
    # 获取用户信息
    username = params['username']
    password = params['password']
    
    # 检查用户名是否已经存在
    if @@users.include?(username)
      status 409
      "Username already taken"
    else
      # 存储用户信息
      @@users[username] = password
      "User registered successfully"
    end
  end

  
  # 登录路由
  post '/login' do
    username = params['username']
    password = params['password']
    
    # 验证用户信息
    if @@users[username] == password
      session['username'] = username
      "User logged in successfully"
    else
      status 401
      "Invalid username or password"
    end
  end

  # 受保护的路由，只有登录用户才能访问
  get '/protected' do
    # 检查用户是否登录
    unless session['username']
      status 401
      "Access denied. Please login first."
    else
      "Welcome to the protected area, #{session['username']}!"
    end
  end

  # 登出路由
  get '/logout' do
    session.clear
    "User logged out successfully"
  end

end

# 启动SINATRA服务器
run AccessControlApp