# 代码生成时间: 2025-08-08 06:01:35
# ImageResizer is a Sinatra application that allows users to batch resize images.
class ImageResizer < Sinatra::Application
  # POST request to upload and resize images
  post '/images' do
    # Check if the request has the file part
    halt 400, 'No files were uploaded.' unless params[:file]

    # Read the uploaded image file
    image = params[:file][:tempfile]
    filename = params[:file][:filename]

    # Validate the file type
    unless File.extname(filename).downcase == '.jpg' || File.extname(filename).downcase == '.png'
      halt 400, 'Unsupported file format.'
    end

    # Resize the image to the specified dimensions
    target_width = params[:width] || 800
    target_height = params[:height] || 600
    image = MiniMagick::Image.read(image) do |img|
      img.resize "#{target_width}x#{target_height}#"
    end

    # Create a tempfile to store the resized image
    resized_image = Tempfile.new(['resized', File.extname(filename)])
    resized_image.binmode
    resized_image.write image.to_blob
    resized_image.rewind

    # Return the resized image as a file to the client
    content_type 'image/jpeg'
    resized_image.path
  ensure
    resized_image.close if resized_image
  end

  # The error handling for unsupported file formats
  error MiniMagick::Invalid do
    'Invalid image file.'
  end
end

# Run the application if it's the main program
run! if app_file == $0