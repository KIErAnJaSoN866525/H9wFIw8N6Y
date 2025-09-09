# 代码生成时间: 2025-09-10 01:46:07
# 数据库配置
configure :development do
  ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'development.sqlite3'
  )
end

# 数据模型 User
class User < ActiveRecord::Base
  # 确保每个用户都有唯一的用户名
  validates :username, presence: true, uniqueness: true
  # 确保密码字段存在但不用于验证
  validates :password, presence: true
end

# Sinatra 路由
class SinatraApp < Sinatra::Base
  # 首页显示所有用户
  get '/' do
    @users = User.all
    erb :index
  end

  # 用户创建
  post '/users' do
    user = User.new(params[:user])
    if user.save
      redirect '/?success=true'
    else
      redirect '/?error=true'
    end
  end

  # 错误处理
  error ActiveRecord::RecordInvalid do
    'User could not be created.'
  end
end

# 视图模板
__END__

@@index
<!DOCTYPE html>
<html>
<head>
  <title>Sinatra Users</title>
</head>
<body>
  <h1>Users</h1>
  <% if params['success'] %>
    <p>User created successfully!</p>
  <% end %>
  <% if params['error'] %>
    <p>Error creating user.</p>
  <% end %>
  <form action='/users' method='post'>
    <label for='username'>Username:</label>
    <input type='text' id='username' name='user[username]' required>
    <label for='password'>Password:</label>
    <input type='password' id='password' name='user[password]' required>
    <button type='submit'>Create User</button>
  </form>
  <ul>
    <% @users.each do |user| %>
      <li><%= user.username %> - <%= user.password %></li>
    <% end %>
  </ul>
</body>
</html>
