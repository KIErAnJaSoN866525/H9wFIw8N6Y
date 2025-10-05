# 代码生成时间: 2025-10-05 19:39:56
# 作业管理平台
class HomeworkManagementPlatform < Sinatra::Application

  # 设置默认的视图文件夹
  set :views, 'views'
  # 设置默认的公共文件夹
  set :public_folder, 'public'

  # 主页，显示作业列表
  get '/' do
    @homeworks = Homework.all
    erb :index
  end

  # 作业详情页面
  get '/homework/:id' do
    @homework = Homework.find(params[:id])
    if @homework
      erb :show
    else
      status 404
      "Homework not found"
    end
  end

  # 创建作业
  post '/homework' do
    homework = Homework.new(homework_params)
    if homework.save
      redirect "/homework/#{homework.id}"
    else
      status 400
      "Failed to create homework"
    end
  end

  # 更新作业
  put '/homework/:id' do
    homework = Homework.find(params[:id])
    if homework.update(homework_params)
      redirect "/homework/#{homework.id}"
    else
      status 400
      "Failed to update homework"
    end
  end

  # 删除作业
  delete '/homework/:id' do
    homework = Homework.find(params[:id])
    homework.destroy
    redirect '/'
  end

  # 辅助方法，获取作业参数
  def homework_params
    params.require(:homework).permit(:title, :description, :due_date)
  end

end

# 作业模型
class Homework < ActiveRecord::Base
  # 确保作业标题、描述和截止日期存在
  validates :title, :description, :due_date, presence: true
end

# 数据库迁移文件
# homeworks.rb
# class CreateHomeworks < ActiveRecord::Migration[6.0]
#   def change
#     create_table :homeworks do |t|
#       t.string :title
#       t.text :description
#       t.date :due_date
#     end
#   end
# end

# 视图文件（views/index.erb）
# <% @homeworks.each do |homework| %>
#   <div>
#     <h3><%= homework.title %></h3>
#     <p><%= homework.description %></p>
#     <p>Due Date: <%= homework.due_date %></p>
#     <a href="/homework/<%= homework.id %>">View</a>
#   </div>
# <% end %>

# 视图文件（views/show.erb）
# <h1><%= @homework.title %></h1>
# <p><%= @homework.description %></p>
# <p>Due Date: <%= @homework.due_date %></p>
# <a href="/">Back to List</a>

# 公共文件（public/css/style.css）
# body {
#   font-family: Arial, sans-serif;
# }
# div {
#   margin-bottom: 20px;
# }
