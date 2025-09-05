# 代码生成时间: 2025-09-05 19:49:51
# Excel表格自动生成器的Sinatra应用
class ExcelGeneratorApp < Sinatra::Application

  # 首页，提供下载Excel文件的选项
  get '/' do
    "Welcome to the Excel Generator!"
  end

  # POST请求，用于生成Excel文件
  post '/create_excel' do
    # 获取参数
    params = params.to_hash
    rows = params['rows'].to_i
    cols = params['cols'].to_i
    file_name = params['file_name'].to_s.strip

    # 错误处理
    if rows <= 0 || cols <= 0 || file_name.empty?
      return status(400), "{"error": "Invalid parameters provided."}"
    end

    # 创建一个新的Excel文件
    excel = Roro::Spreadsheet.new(excelx: "#{file_name}.xlsx")
    sheet = excel.add_sheet('Sheet 1')

    # 填充数据到Excel文件
    rows.times do |i|
      cols.times do |j|
        sheet.cell(i + 1, j + 1, "Cell #{i + 1},#{j + 1}")
      end
    end

    # 保存文件
    File.open("#{file_name}.xlsx", 'wb') do |f|
      f.write(excel.to_stream.read)
    end

    # 返回文件的下载链接
    "{"download_url": "http://#{request.host}/download/#{file_name}.xlsx"}"
  end

  # 提供下载Excel文件的服务
  get '/download/:filename' do
    filename = params[:filename]
    send_file "#{filename}", type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', disposition: 'attachment'
  end
end

# 注意：这个示例代码使用了Roo库来处理Excel文件的创建。
# 请确保在运行前已经安装了'roo'和'roo-xls' gem。
# 此外，这个代码示例没有实现复杂的错误处理和安全措施，
# 在实际应用中需要增加更多的安全检查和异常处理。