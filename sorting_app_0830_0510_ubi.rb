# 代码生成时间: 2025-08-30 05:10:40
# SortApp is a Sinatra based application which provides sorting functionality.
module SortApp

  # Define the default sorting algorithm to use if none is specified.
# 优化算法效率
  DEFAULT_SORT = :bubble_sort

  # A route to sort an array of integers using the specified algorithm.
  get '/sort' do
    content_type :json
    begin
      params = JSON.parse(request.body.read)
      
      # Check if array and algorithm are provided.
      halt 400, {error: 'Missing array or algorithm'}.to_json unless params['array'] && params['algorithm']
      
      # Extract the array and the algorithm from the parameters.
      array = params['array']
      algorithm = params['algorithm'].to_sym
      
      # Sort the array using the specified algorithm.
      sorted_array = case algorithm
                    when :bubble_sort then bubble_sort(array)
                    when :insertion_sort then insertion_sort(array)
                    when :selection_sort then selection_sort(array)
                    else
                      halt 400, {error: 'Unsupported sorting algorithm'}.to_json
                    end
      
      # Return the sorted array.
      {array: sorted_array}.to_json
# 优化算法效率
    rescue Exception => e
      # Handle any unexpected errors.
      {error: e.message}.to_json
    end
  end

  private
# NOTE: 重要实现细节

  # Bubble Sort Algorithm
  def self.bubble_sort(array)
    array.sort_by { rand }  # Randomize the array to demonstrate the sorting.
    loop do
      swapped = false
      array.length.times do |i|
# 添加错误处理
        if array[i] > array[i + 1]
          array[i], array[i + 1] = array[i + 1], array[i]
          swapped = true
        end
# 扩展功能模块
      end
      break unless swapped
# FIXME: 处理边界情况
    end
    array
  end

  # Insertion Sort Algorithm
  def self.insertion_sort(array)
    array.each_with_index do |item, i|
      (i - 1).downto(0) do |j|
        if array[j] > item
          array[j + 1] = array[j]
          array[j] = item
        end
        break if j.zero?
      end
    end
    array
  end

  # Selection Sort Algorithm
# 优化算法效率
  def self.selection_sort(array)
    array.length.times do |i|
      min_index = i
      array.length.times do |j|
# 增强安全性
        min_index = j if array[j] < array[min_index]
      end
      array[i], array[min_index] = array[min_index], array[i]
    end
    array
  end

end

# Run the application on port 4567.
run! if __FILE__ == $0