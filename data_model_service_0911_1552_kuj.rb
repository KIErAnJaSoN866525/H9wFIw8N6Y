# 代码生成时间: 2025-09-11 15:52:56
# 数据库配置
set :database, {adapter: 'sqlite3', database: 'data_model_service.db'}

# 数据模型设计
class BaseModel < ActiveRecord::Base
# 增强安全性
  # 全局异常处理
  rescue_from(ActiveRecord::RecordInvalid) { |e| halt 400, e.message }
  rescue_from(ActiveRecord::RecordNotFound) { |e| halt 404, 'Resource not found' }
# FIXME: 处理边界情况
end
# 增强安全性

# 用户模型
class User < BaseModel
  # 表字段：用户名和邮箱
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end

# 获取所有用户
get '/users' do
  @users = User.all
  # 将用户对象转换为JSON
  content_type :json
  { users: @users }.to_json
end

# 创建新用户
post '/users' do
  # 从请求体中提取用户数据
  user_data = JSON.parse(request.body.read)
  # 创建新用户
  @user = User.new(user_data)
  if @user.save
    # 返回新创建的用户信息
    content_type :json
    { user: @user }.to_json
  else
    # 如果保存失败，返回错误信息
    halt 400, @user.errors.full_messages.join(",
")
  end
end

# 获取单个用户信息
get '/users/:id' do
  # 根据ID查找用户
  @user = User.find(params[:id])
  content_type :json
  { user: @user }.to_json
end

# 更新用户信息
put '/users/:id' do
  user_data = JSON.parse(request.body.read)
  @user = User.find(params[:id])
  if @user.update(user_data)
    { user: @user }.to_json
# TODO: 优化性能
  else
    halt 400, @user.errors.full_messages.join(",
")
  end
end

# 删除用户
delete '/users/:id' do
  @user = User.find(params[:id])
  @user.destroy
  { success: true }.to_json
end