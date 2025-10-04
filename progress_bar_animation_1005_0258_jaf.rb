# 代码生成时间: 2025-10-05 02:58:29
# 进度条和加载动画的Sinatra程序
# 作者：[您的名字]
# 日期：[今天的日期]

# 进度条和加载动画的主要页面
get '/' do
  erb :index
end

# 进度条和加载动画的页面
get '/loading' do
  erb :loading
end

# 设置视图文件夹
set :views, File.dirname(__FILE__) + '/views'

# 进度条和加载动画的HTML视图文件
__END__

@@index
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>进度条和加载动画</title>
  <style>
    /* 进度条的样式 */
    .progress-bar {
      width: 100%;
      background-color: #ddd;
      border-radius: 5px;
    }
    .progress {
      height: 30px;
      background-color: #4CAF50;
      text-align: center;
      line-height: 30px;
      color: white;
      border-radius: 5px;
    }
    /* 加载动画的样式 */
    .loader {
      border: 8px solid #f3f3f3;
      border-top: 8px solid #3498db;
      border-radius: 50%;
      width: 50px;
      height: 50px;
      animation: spin 2s linear infinite;
    }
    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }
  </style>
</head>
<body>
  <h1>进度条和加载动画</h1>
  <div class="progress-bar">
    <div class="progress" style="width: 0%;">0%</div>
  </div>
  <button onclick="startProgress(50);">开始进度条</button>
  <div class="loader" style="display: none;"></div>
  <script>
    // 开始进度条的函数
    function startProgress(duration) {
      var progressBar = document.querySelector('.progress');
      var loader = document.querySelector('.loader');
      var start = Date.now();
      var width = 0;
      var interval = setInterval(function () {
        var now = new Date().getTime();
        var elapsed = now - start;
        var percent = Math.min(elapsed / duration * 100, 100);
        width = percent * 1;
        progressBar.style.width = width + '%';
        progressBar.textContent = width + '%';
        if (percent === 100) {
          clearInterval(interval);
          loader.style.display = 'block';
          setTimeout(function () {
            loader.style.display = 'none';
          }, 2000);
        }
      }, 10);
    }
  </script>
</body>
</html>

@@loading
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>加载动画</title>
  <style>
    /* 加载动画的样式 */
    .loader {
      border: 8px solid #f3f3f3;
      border-top: 8px solid #3498db;
      border-radius: 50%;
      width: 50px;
      height: 50px;
      animation: spin 2s linear infinite;
      margin: 0 auto;
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
    }
    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }
  </style>
</head>
<body>
  <h1>加载动画</h1>
  <div class="loader"></div>
</body>
</html>