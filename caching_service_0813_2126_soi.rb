# 代码生成时间: 2025-08-13 21:26:14
# 缓存服务类
class CachingService
  # 缓存存储
  @@cache = {}
  
  # 获取缓存数据
  def self.get(key)
    @@cache[key]
  end
  
  # 设置缓存数据
  def self.set(key, value, ttl = 3600) # ttl in seconds, default is 1 hour
    @@cache[key] = {
      value: value,
      expires_at: Time.now + ttl
    }
    @@cache[key]
  end
  
  # 检查缓存是否过期
  def self.expired?(key)
    cached = @@cache[key]
    return false unless cached
    cached[:expires_at] <= Time.now
  end
end

# Sinatra 应用
class CachingApp < Sinatra::Base
  configure do
    set :server, 'thin'
    set :port, 4567
  end

  get '/' do
    "Hello, this is a caching service!"
  end

  get '/cache/:key' do |key|
    cached_data = CachingService.get(key)
    if cached_data.nil? || CachingService.expired?(key)
      status 404
      {error: 'Cache not found or expired'}.to_json
    else
      {value: cached_data[:value]}.to_json
    end
  end

  post '/cache' do
    content_type :json
    key = params['key']
    value = params['value']
    ttl = params['ttl'] || 3600 # 默认1小时
    
    if key.nil? || value.nil?
      status 400
      {error: 'Key and value are required'}.to_json
    else
      cached_response = CachingService.set(key, value, ttl)
      {key: key, value: cached_response[:value]}.to_json
    end
  end
end

# 启动 Sinatra 服务
run CachingApp