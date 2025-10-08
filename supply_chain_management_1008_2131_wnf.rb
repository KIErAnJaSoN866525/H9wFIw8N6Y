# 代码生成时间: 2025-10-08 21:31:44
# 供应链管理系统 API
class SupplyChainManagement < Sinatra::Base

  # 定义一个简单的数据库存储结构
  suppliers = []
  products = []
  orders = []

  # 获取所有供应商
  get '/suppliers' do
    content_type :json
    suppliers.to_json
  end

  # 添加一个新的供应商
  post '/suppliers' do
    content_type :json
    supplier = JSON.parse(request.body.read)
    unless supplier['name'] && supplier['address']
      halt 400, {'error' => 'Invalid supplier data'}.to_json
    end
    suppliers.push(supplier)
    {'message' => 'Supplier added successfully'}.to_json
  end

  # 获取所有产品
  get '/products' do
    content_type :json
    products.to_json
  end

  # 添加一个新的产品
  post '/products' do
    content_type :json
    product = JSON.parse(request.body.read)
    unless product['name'] && product['supplier_id'] && product['price']
      halt 400, {'error' => 'Invalid product data'}.to_json
    end
    products.push(product)
    {'message' => 'Product added successfully'}.to_json
  end

  # 获取所有订单
  get '/orders' do
    content_type :json
    orders.to_json
  end

  # 添加一个新的订单
  post '/orders' do
    content_type :json
    order = JSON.parse(request.body.read)
    unless order['items'] && order['customer_id']
      halt 400, {'error' => 'Invalid order data'}.to_json
    end
    orders.push(order)
    {'message' => 'Order added successfully'}.to_json
  end

  # 错误处理
  not_found do
    content_type :json
    {'error' => 'Not Found'}.to_json
  end

  # 服务器错误处理
  error do
    content_type :json
    e = request.env['sinatra.error']
    {'error' => e.message}.to_json
  end

end

# 运行Sinatra服务器
run! if __FILE__ == $0