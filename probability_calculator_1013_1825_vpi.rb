# 代码生成时间: 2025-10-13 18:25:04
# 概率分布计算器
class ProbabilityCalculator < Sinatra::Base
  # 计算二项分布概率
  get '/binary' do
    # 解析请求参数
# 添加错误处理
    trials = params['trials'].to_i
    successes = params['successes'].to_i
# 扩展功能模块
    probability = params['probability'].to_f
# NOTE: 重要实现细节

    # 检查参数有效性
    unless trials > 0 && successes >= 0 && probability > 0 && probability <= 1
      error 'Invalid parameters'
    end

    # 计算二项分布概率
    probability_ = 0
    for k in 0..successes
      probability_ += (factorial(trials) / (factorial(k) * factorial(trials - k))) * (probability ** k) * ((1 - probability) ** (trials - k))
    end

    # 返回概率
# NOTE: 重要实现细节
    'Probability of exactly ' + successes.to_s + ' successes in ' + trials.to_s + ' trials is ' + probability_.round(4).to_s
  end

  private

  # 计算阶乘
  def factorial(n)
# 增强安全性
    return 1 if n <= 1
    n * factorial(n - 1)
  end

  # 错误处理
  def error(message)
    halt 400, { 'Content-Type' => 'text/plain' }, message
  end
# 改进用户体验
end

# 设置端口和启动SINATRA服务
set :port, 4567
run! if app_file == $0
