# 代码生成时间: 2025-09-20 01:49:48
# Excel表格自动生成器
class ExcelGeneratorApp < Sinatra::Base

  # 路由：根路径，返回生成Excel文件的表单页面
  get '/' do
    erb :index
  end

  # 路由：提交表单，处理Excel生成请求
  post '/generate' do
    begin
      # 获取表单数据
      title = params['title']
      rows = params['rows'].to_i
      columns = params['columns'].to_i

      # 检查数据有效性
      raise 'Title is required' if title.nil? || title.empty?
      raise 'Invalid rows or columns' if rows <= 0 || columns <= 0

      # 使用Roo库创建Excel文件
      excel = Roo::Spreadsheet.new("#{title}.xlsx")
      excel.default_sheet

      # 填充Excel表格数据
      (1..rows).each do |row|
        (1..columns).each do |col|
          excel.cell(row, col, "Cell #{row},#{col}")
        end
      end

      # 保存Excel文件
      excel.save

      # 返回成功信息和下载链接
      "Excel file '#{title}.xlsx' generated successfully. <a href='/#{title}.xlsx'>Download</a>"
    rescue => e
      # 返回错误信息
      "Error: #{e.message}"
    end
  end

  # 路由：下载生成的Excel文件
  get '/:filename.xlsx' do
    content_type 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    attachment params[:filename] + '.xlsx'
    File.open(params[:filename] + '.xlsx', 'rb') { |f| f.read }
  end

end

# 使用Roo库创建Excel文件
# 需要安装roo和spreadsheet gems
# gem install roo spreadsheet

# 注意：本代码示例仅供参考，实际部署时需要确保文件存储和权限管理的安全。