# 代码生成时间: 2025-09-16 06:22:01
# 配置数据库连接
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'app.sqlite'
)

# 定义数据库模型
class User < ActiveRecord::Base
  # 使用ActiveRecord防止SQL注入
end

# 设置Sinatra路由
get '/' do
  # 显示用户列表页面
  @users = User.all
  erb :index
end

get '/users/new' do
  # 创建新用户界面
  erb :new_user
end

post '/users' do
  # 创建新用户
  user = User.new(params[:user])
  if user.save
    redirect '/users'
  else
    @error = user.errors.full_messages.join(', ')
    erb :new_user
  end
end

# Sinatra模板文件
__END__

@@index
<!DOCTYPE html>
<html>
<head>
  <title>User List</title>
</head>
<body>
  <h1>User List</h1>
  <ul>
    <% @users.each do |user| %>
      <li><%= user.name %> - <%= user.email %></li>
    <% end %>
  </ul>
  <a href="/users/new">Create New User</a>
</body>
</html>

@@new_user
<!DOCTYPE html>
<html>
<head>
  <title>Create New User</title>
</head>
<body>
  <h1>Create New User</h1>
  <% if @error.present? %>
    <p style="color: red";><%= @error %></p>
  <% end %>
  <form action="/users" method="POST">
    <label for="name">Name:</label>
    <input type="text" name="user[name]" id="name" required>
    <br>
    <label for="email">Email:</label>
    <input type="email" name="user[email]" id="email" required>
    <br>
    <input type="submit" value="Create User">
  </form>
  <a href="/">Back to User List</a>
</body>
</html>
