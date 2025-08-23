# 代码生成时间: 2025-08-23 19:11:43
# 定义一个简单的用户界面组件库
class UIComponentLibrary < Sinatra::Base

  # 根路径，展示所有可用组件的列表
  get '/' do
    erb :index
  end

  # 组件路径，用于展示具体的组件
  get '/components/:component_name' do
    component_name = params['component_name']
    # 检查组件是否存在
    unless component_exists?(component_name)
      status 404
      erb :'components/not_found'
    else
      erb :"components/#{component_name}"
    end
  end

  private

  # 检查组件是否存在的方法
  def component_exists?(name)
    File.exist?(File.join(settings.views, "components/#{name}.erb"))
  end
end

# 设置Sinatra的视图文件路径
set :views, Proc.new { File.join(root, 'views') }

# 启动Sinatra应用程序
run! if app_file == $0