# 代码生成时间: 2025-09-15 06:55:36
# HashCalculator is a Sinatra-based web application for calculating hash values.
class HashCalculator < Sinatra::Base

  # GET / calculates the hash for the input text provided in the query string.
  get '/' do
    # Check if there is a 'text' parameter in the query string.
    if params['text'].nil? || params['text'].empty?
      # Return an error message if 'text' is missing or empty.
      content_type :json
      {
        status: :error,
        message: 'Please provide the text to calculate the hash.'
      }.to_json
    else
      # Calculate the hash for the provided text.
      hash_value = Digest::SHA256.hexdigest(params['text'])
      # Return the hash value as a JSON object.
      content_type :json
      {
        status: :success,
        hash_value: hash_value
      }.to_json
    end
  end

  # Not Found handler for Sinatra, to return JSON error for undefined routes.
  not_found do
    content_type :json
    {
      status: :error,
      message: 'The requested route is not found.'
    }.to_json
  end

  # Error handler for Sinatra, to return JSON error for internal server errors.
  error do
    e = request.env['sinatra.error']
    puts e.message
    puts e.backtrace.join('
')
    content_type :json
    {
      status: :error,
      message: 'An unexpected error occurred.'
    }.to_json
  end

end

# Run the application if this is the main file.
run! if __FILE__ == $0