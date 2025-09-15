# 代码生成时间: 2025-09-15 20:22:40
# MathToolkit is a Sinatra application that provides basic math operations.
class MathToolkit < Sinatra::Base

  # GET / - Display a simple form for math operations
  get '/' do
    erb :index
  end

  # POST /calculate - Process the math operation form submission
  post '/calculate' do
    operation = params['operation']
    a = params['a'].to_f
    b = params['b'].to_f

    case operation
    when 'add'
      result = a + b
    when 'subtract'
      result = a - b
    when 'multiply'
      result = a * b
    when 'divide'
      result = a / b
    else
      return erb :error, locals: { error_message: 'Invalid operation selected' }
    end

    erb :result, locals: { result: result, a: a, b: b, operation: operation }
  end

  # Error page for unsupported operations
  error Sinatra::NotFound do
    erb :not_found
  end

end

# Views
# index.erb - The main form for math operations
__END__
@@index
<!DOCTYPE html>
<html>
<head>
  <title>Math Toolkit</title>
</head>
<body>
  <h1>Math Toolkit</h1>
  <form action="/calculate" method="post">
    <label for="a">Number A: <input type="text" name="a" id="a" required></label><br>
    <label for="b">Number B: <input type="text" name="b" id="b" required></label><br>
    <input type="submit" name="operation" value="Add">
    <input type="submit" name="operation" value="Subtract">
    <input type="submit" name="operation" value="Multiply">
    <input type="submit" name="operation" value="Divide">
  </form>
</body>
</html>

@@result
<!DOCTYPE html>
<html>
<head>
  <title>Result</title>
</head>
<body>
  <h1>Result</h1>
  <p>Result of <%= params[:operation] %> between <%= params[:a] %> and <%= params[:b] %> is: <%= @result %></p>
  <a href="/">Try another operation</a>
</body>
</html>

@@error
<!DOCTYPE html>
<html>
<head>
  <title>Error</title>
</head>
<body>
  <h1>Error</h1>
  <p><%= @error_message %></p>
  <a href="/">Try again</a>
</body>
</html>

@@not_found
<!DOCTYPE html>
<html>
<head>
  <title>Not Found</title>
</head>
<body>
  <h1>404 Not Found</h1>
  <p>The page you are looking for does not exist.</p>
</body>
</html>
