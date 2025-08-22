# 代码生成时间: 2025-08-22 22:44:47
# 文档转换器服务
class DocumentConverter < Sinatra::Application

  # 首页路由，提供文档转换的表单
  get '/' do
    erb :index
  end

  # 提交文档转换请求的路由
  post '/convert' do
    # 检查上传的文件是否存在
    unless params[:file]
      status 400
      return { error: '请上传文件' }.to_json
    end

    # 读取上传的文件
    uploaded_file = params[:file][:tempfile]
    file_name = params[:file][:filename]
    file_type = params[:file][:type]

    # 根据文件类型进行不同的处理
    case file_type
    when 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
      converted = convert_to_pdf(uploaded_file, file_name)
    else
      status 415
      return { error: '不支持的文件类型' }.to_json
    end

    # 返回转换结果
    {
      status: 'success',
      filename: converted
    }.to_json
  end

  private

  # 将Word文档转换为PDF
  def convert_to_pdf(file, name)
    # 使用roo库读取Word文档
    workbook = Roro::Excel.new(file)
    # 这里只是一个示例，实际转换为PDF需要更复杂的处理
    # 例如，使用 LibreOffice 或其他库
    # 这里仅返回文件名作为示例
    "#{name}.pdf"
  end
end

# 设置静态文件目录
set :public_folder, 'public'
set :views, 'views'

# 启动程序
run! if app_file == $0
