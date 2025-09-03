# 代码生成时间: 2025-09-04 01:14:32
# 引入XSS防护库
require 'rack/protection'

# 启用Rack::Protection中间件，启用XSS防护
use Rack::Protection::XSSHeader

get '/' do
  # 显示一个简单的表单，用于输入用户数据
  erb :index
end

post '/submit' do
  # 获取用户输入的数据
  user_input = params[:data]

  # 在返回给用户之前，对输入的数据进行HTML转义处理，以防止XSS攻击
  escaped_input = Rack::Utils.escape_html(user_input)

  # 返回处理后的数据
  "提交的数据: #{escaped_input}"
end

__END__

@@index.erb
<form action="/submit" method="post">
  <label for="data">输入数据:</label><br>
  <input type="text" id="data" name="data" required><br><br>
  <input type="submit" value="提交">
</form>