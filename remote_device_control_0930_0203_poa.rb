# 代码生成时间: 2025-09-30 02:03:21
# 远程设备控制程序
class RemoteDeviceControl < Sinatra::Application

  # 路由：获取设备状态
  get '/devices/:device_id/state' do
    device_id = params['device_id']
    device = Device.find(device_id)
    
    if device
      content_type :json
      {
        state: device.state,
        name: device.name
      }.to_json
    else
      status 404
      {
        error: 'Device not found'
      }.to_json
    end
  end

  # 路由：设置设备状态
  post '/devices/:device_id/state' do
    device_id = params['device_id']
    data = JSON.parse(request.body.read)
    device = Device.find(device_id)
    
    if device
      device.update_state(data['state'])
      content_type :json
      {
        state: device.state,
        name: device.name
      }.to_json
    else
      status 404
      {
        error: 'Device not found'
      }.to_json
    end
  end

  # 设备类
  class Device
    # 存储所有设备的状态
    @@devices = {}

    # 获取设备
    def self.find(device_id)
      @@devices[device_id]
    end

    # 创建设备
    def initialize(name, state)
      @name = name
      @state = state
    end

    # 更新设备状态
    def update_state(new_state)
      @state = new_state
    end
  end

  # 模拟设备
  Device.new('Lamp', 'off')
  Device.new('AC', 'off')

end