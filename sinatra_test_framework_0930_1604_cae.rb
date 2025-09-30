# 代码生成时间: 2025-09-30 16:04:42
# 定义一个简单的 Sinatra 应用
class MyApp < Sinatra::Base
  get '/' do
    'Hello, world!'
  end
end

# 使用 RSpec 进行单元测试
RSpec.describe 'MyApp' do
  include Rack::Test::Methods

  def app
    MyApp
  end

  # 测试根路径的响应
  describe 'GET /' do
    it 'responds with a success status' do
      get '/'
      expect(last_response).to be_ok
    end

    it 'responds with the correct message' do
      get '/'
      expect(last_response.body).to eq('Hello, world!')
    end
  end
end

# Sinatra 应用的配置
configure do
  # 设置环境为测试环境
  set :environment, :test
end
