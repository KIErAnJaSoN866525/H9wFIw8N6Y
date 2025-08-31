# 代码生成时间: 2025-08-31 09:44:52
# System Performance Monitor
# This Sinatra application provides a simple interface to monitor system performance.

require 'sinatra'
require 'json'
require 'open3'

# Helper method to execute system commands and capture their outputs
def execute_command(command)
  output, error, status = Open3.capture3(command)
  unless status.success?
    raise "Error executing command '#{command}': #{error.strip}"
  end
  output
end

# Route to display the home page
get '/' do
  erb :index
end

# Route to get CPU usage data
get '/cpu' do
  cpu_data = execute_command('top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/"').strip
  { cpu_usage: cpu_data }.to_json
end

# Route to get memory usage data
get '/memory' do
  memory_data = execute_command('free -m | grep Mem | awk '{print $3/$2 * 100.0}').strip
  { memory_usage: memory_data }.to_json
end

# Route to get disk usage data
get '/disk' do
  disk_data = execute_command('df -h | grep \"/dev\" | awk \'{print $5}' | sed \'s/\/%//\\'').strip
  { disk_usage: disk_data }.to_json
end

__END__

@@ index
<!DOCTYPE html>
<html>
<head>
  <title>System Performance Monitor</title>
</head>
<body>
  <h1>System Performance Monitor</h1>
  <p><a href='/cpu'>CPU Usage</a></p>
  <p><a href='/memory'>Memory Usage</a></p>
  <p><a href='/disk'>Disk Usage</a></p>
</body>
</html>
