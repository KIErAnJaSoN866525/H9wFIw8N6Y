# 代码生成时间: 2025-10-14 02:39:20
# 折扣优惠系统
class DiscountSystem < Sinatra::Base

  # 提供折扣优惠的接口
  get '/discount/:product_id' do
    # 获取产品ID
    product_id = params['product_id']

    # 检查产品ID是否有效
    product = Product.find_by(id: product_id)
    unless product
      status 404
      return { error: 'Product not found' }.to_json
    end

    # 计算折扣
    discount = calculate_discount(product)

    # 返回折扣结果
    {
      product_id: product.id,
      discount: discount
    }.to_json
  end

  private

  # 计算折扣的方法
  def calculate_discount(product)
    # 根据产品类型和购买数量计算折扣
    case product.type
    when 'electronic'
      product.price * 0.1 # 电子产品10%折扣
    when 'book'
      product.price * 0.05 # 书籍5%折扣
    else
      0 # 其他类型无折扣
    end
  end
end

# 产品模型
class Product
  # 模拟数据库中的产品数据
  @@products = [
    { id: 1, type: 'electronic', price: 100.0 },
    { id: 2, type: 'book', price: 20.0 },
    { id: 3, type: 'clothing', price: 50.0 }
  ]

  # 根据ID查找产品
  def self.find_by(id:)
    @@products.find { |product| product[:id] == id }
  end
end

# 启动Sinatra服务
run! if app_file == $0