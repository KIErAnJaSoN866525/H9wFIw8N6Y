# 代码生成时间: 2025-08-07 16:07:39
# ProcessManager is a Sinatra-based application that allows users to manage system processes.
# It includes features like listing processes, killing a process, and viewing process details.
class ProcessManager < Sinatra::Base

  # GET / processes endpoint to list all processes
  get '/processes' do
    content_type :json
    processes = `ps aux`.split("
")
    JSON.pretty_generate(processes)
  end

  # GET / processes/:pid endpoint to show details of a process with :pid
  get '/processes/:pid' do
    content_type :json
    pid = params[:pid]
    process = `ps -p #{pid} -o pid,user,etime,rss,vsz,comm`.chomp
    { pid: pid, process: process }.to_json
  end

  # POST / processes/:pid/kill endpoint to kill a process with :pid
  post '/processes/:pid/kill' do
    content_type :json
    pid = params[:pid]
    begin
      system("kill #{pid}")
      { success: true, message: "Process #{pid} killed successfully." }.to_json
    rescue StandardError => e
      { success: false, error: e.message }.to_json
    end
  end

  # Error handling for 404 errors
  not_found do
    content_type :json
    { error: 'Not found' }.to_json
  end

  # Error handling for other errors
  error do
    content_type :json
    { error: 'An unexpected error has occurred' }.to_json
  end

end

# Running the ProcessManager application on port 4567
set :port, 4567
run! if app_file == $0
