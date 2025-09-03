# 代码生成时间: 2025-09-03 21:25:09
# ShoppingCartApp is a Sinatra application that implements a simple shopping cart.
class ShoppingCartApp < Sinatra::Base

  # Initialize the cart in the session
  get '/' do
    if session[:cart].nil?
      session[:cart] = {}
    end
    erb :index
  end

  # Add an item to the cart
  post '/add_item' do
    content_type :json
    item_id = params['item_id']
    item_quantity = params['quantity'].to_i
    
    # Error handling for missing parameters
    if item_id.nil? || item_quantity <= 0
      {error: 'Invalid parameters'}.to_json
    else
      # Add or update the item in the cart
      if session[:cart][item_id]
        session[:cart][item_id] += item_quantity
      else
        session[:cart][item_id] = item_quantity
      end
      
      # Return the updated cart as JSON
      {cart: session[:cart]}.to_json
    end
  end

  # Remove an item from the cart
  post '/remove_item' do
    content_type :json
    item_id = params['item_id']
    
    # Error handling for missing item_id
    if item_id.nil?
      {error: 'Item id is required'}.to_json
    else
      # Remove the item from the cart
      session[:cart].delete(item_id)
      {cart: session[:cart]}.to_json
    end
  end

  # Display the cart contents
  get '/cart' do
    content_type :json
    {cart: session[:cart]}.to_json
  end

  # Clear the cart
  post '/clear_cart' do
    content_type :json
    session[:cart] = {}
    {cart: session[:cart]}.to_json
  end

end

# Run the application if this file is executed directly
run! if app_file == $0
