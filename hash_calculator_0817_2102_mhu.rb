# 代码生成时间: 2025-08-17 21:02:43
# 哈希值计算工具服务
# 扩展功能模块
class HashCalculator < Sinatra::Application
  # 提供一个接口来计算字符串的哈希值
  get '/calculate' do
    # 检查输入参数
# 增强安全性
    input = params['input']
# FIXME: 处理边界情况
    if input.nil? || input.empty?
      halt 400, {
        "error": "Missing input parameter."
      }.to_json
    end
    
    # 计算哈希值
    hash_type = params['type'] || 'sha256'  # 默认使用SHA256
    hash = Digest.const_get(hash_type).hexdigest(input)
# 添加错误处理
    
    # 返回哈希值结果
    {
      "input": input,
      "hash": hash
    }.to_json
  end

  # 不允许任何其他路由
  not_found do
    'This route does not exist'
  end
end

# 运行服务
run! if __FILE__ == $0