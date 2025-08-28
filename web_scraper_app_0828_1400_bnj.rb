# 代码生成时间: 2025-08-28 14:00:35
# WebScraperApp is a Sinatra application for scraping web content.
class WebScraperApp < Sinatra::Base
  # Endpoint to get a webpage content
  get '/scrape/:url' do
    # Extract the URL from the query parameter
    url = params[:url]
    halt 400, { error: 'URL parameter is missing' }.to_json unless url

    begin
      # Open and read the content of the URL
      html_content = open(url).read
      # Parse the HTML content using Nokogiri
      parsed_html = Nokogiri::HTML(html_content)

      # Return the parsed HTML as JSON
      { content: parsed_html.to_s }.to_json
    rescue OpenURI::HTTPError => e
      # Handle HTTP errors (e.g., 404 Not Found)
      { error: "HTTP error: #{e.message}" }.to_json
    rescue Nokogiri::XML::XPath::SyntaxError => e
      # Handle parsing errors
      { error: "Parsing error: #{e.message}" }.to_json
    rescue StandardError => e
      # Handle any other standard errors
      { error: "An unexpected error occurred: #{e.message}" }.to_json
    end
  end

  # Set the port and run the app if this file is executed directly
  if __FILE__ == $0
    set :port, 4567
    run! if app_file == $0
  end
end