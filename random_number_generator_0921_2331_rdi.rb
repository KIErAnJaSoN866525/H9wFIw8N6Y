# 代码生成时间: 2025-09-21 23:31:53
# 随机数生成器服务
class RandomNumberGenerator < Sinatra::Application

  # GET请求到 /generate，返回一个随机数
  get '/generate' do
    # 从请求中获取所需的参数
    begin
      min = params[:min].to_i
      max = params[:max].to_i

      # 参数校验
      if min < 0 or max < 0 or min >= max
        halt 400, {'Content-Type' => 'application/json'}, "{"error": "Invalid parameters. Minimum and maximum values must be non-negative and minimum must be less than maximum."}"
      end

      # 生成随机数
      random_number = rand(min..max)
      content_type :json
      {"random_number": random_number}.to_json
    rescue
      # 异常处理
      halt 500, {'Content-Type' => 'application/json'}, "{"error": "Internal Server Error."}"
    end
  end

  # 错误处理
  error do
    # 400错误处理
    e = request.env['sinatra.error']
    status 400
    content_type :json
    {"error": e.message}.to_json
  end
end

# 运行Sinatra应用
run RandomNumberGenerator