# 代码生成时间: 2025-09-13 09:47:14
# FolderOrganizer 是一个 Sinatra 应用，用于整理文件夹结构。
# 它提供基本的错误处理和日志记录功能。
class FolderOrganizer < Sinatra::Base

  # 路由：GET /organize
  # 这个路由将整理指定的目录。
  get '/organize' do
    # 获取请求参数
    dir = params['dir']

    # 检查目录是否存在
    if dir.nil? || !File.directory?(dir)
      'Directory not specified or does not exist.'
    else
      begin
        # 调用整理函数
        organize_directory(dir)
        'Directory organized successfully.'
      rescue => e
        # 错误处理
        'An error occurred: ' + e.message
      end
    end
  end

  private

  # 私有方法：organize_directory
  # 这个方法用于整理指定的目录。
  # 它将子目录和文件按照预设的规则进行排序和移动。
  def organize_directory(dir)
    # 获取目录下的所有文件和子目录
    Dir.entries(dir).each do |entry|
      next if entry == '.' || entry == '..'

      # 构建完整的文件路径
      path = File.join(dir, entry)

      # 如果是文件，移动到指定的文件目录
      if File.file?(path)
        move_to_file_directory(path)
      # 如果是目录，递归整理
      elsif File.directory?(path)
        organize_directory(path)
      end
    end
  end

  # 私有方法：move_to_file_directory
  # 这个方法用于将文件移动到指定的文件目录。
  # 它根据文件扩展名来确定目标目录。
  def move_to_file_directory(file_path)
    # 获取文件扩展名
    extension = File.extname(file_path)
    # 构建目标目录路径
    target_dir = File.join(settings.public_folder, 'files', extension[1..-1])
    # 确保目标目录存在
    FileUtils.mkdir_p(target_dir)
    # 移动文件
    FileUtils.mv(file_path, target_dir)
  end
end

# 设置环境变量
set :public_folder, File.dirname(__FILE__)

# 启动 Sinatra 应用
run! if app_file == $0