# 代码生成时间: 2025-08-01 02:07:03
# DocumentConverter is a Sinatra application for converting documents.
class DocumentConverter < Sinatra::Base
  # Set the root to the public directory
  set :root, File.dirname(__FILE__)
  
  # Endpoint to upload a file and convert it to another format.
  # Only JSON responses are accepted.
  post '/upload' do
    # Check if a file is present
    if params[:file]
      # Store the uploaded file in a temporary directory
      tempfile = params[:file][:tempfile]
      file_name = params[:file][:filename]
      file_path = "/tmp/#{file_name}"
      File.open(file_path, 'wb') { |f| f.write(tempfile.read) }
      
      # Read the uploaded file and convert it to the requested format
      begin
        content_type, converted_content = convert_document(file_path)
        # Send the converted content back to the client as a JSON response
        content_type 'application/json'
        converted_content.to_json
      rescue StandardError => e
        # Handle any errors that occur during conversion
        content_type 'application/json'
        { error: e.message }.to_json
      ensure
        # Clean up by removing the temporary file
        File.delete(file_path) if File.exist?(file_path)
      end
    else
      # Return an error if no file is uploaded
      content_type 'application/json'
      { error: 'No file uploaded' }.to_json
    end
  end

  private
  
  # Converts the document to the requested format
  def convert_document(file_path)
    # Determine the format of the uploaded file
    format = File.extname(file_path)[1..-1]
    
    # Choose the conversion method based on the file format
    case format
    when 'docx'
      # Convert a Word document to a plain text
      convert_docx_to_txt(file_path)
    when 'xlsx'
      # Convert an Excel document to a CSV
      convert_xlsx_to_csv(file_path)
    else
      # Return an error for unsupported formats
      raise 'Unsupported file format'
    end
  end

  # Converts a Word document (.docx) to plain text (.txt)
  def convert_docx_to_txt(file_path)
    # Use the Roo gem to read the Word document
    document = Roo::Spreadsheet.open(file_path)
    # Extract the text from the document
    content = document.sheet(0).cells.map(&:value).join("
")
    # Return the content type and the converted content
    ["text/plain", content]
  end

  # Converts an Excel document (.xlsx) to a CSV file
  def convert_xlsx_to_csv(file_path)
    # Use the Roo gem to read the Excel document
    document = Roo::Spreadsheet.open(file_path)
    # Export the data to a CSV string
    csv_content = CSV.generate do |csv|
      document.sheet(0).rows.each do |row|
        csv << row.map(&:value)
      end
    end
    # Return the content type and the converted content
    ["text/csv", csv_content]
  end

end

# Run the Sinatra application
run! if app_file == $0