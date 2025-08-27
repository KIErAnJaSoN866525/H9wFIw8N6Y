# 代码生成时间: 2025-08-27 17:37:39
# Inventory Management System
class InventoryManagement < Sinatra::Base

  # Initialize an empty hash to store inventory items
  set :inventory, {}

  # Set the route to display the inventory
  get '/inventory' do
    # Convert the inventory hash to a JSON string and return it
    content_type :json
    "#{settings.inventory.to_json}"
  end

  # Set the route to add an item to the inventory
  post '/inventory/:item' do
    item = params['item']
    # Check if the item exists in the inventory
    if settings.inventory.has_key?(item)
      # Increment the quantity of the existing item
      settings.inventory[item] += 1
    else
      # Add the new item with a quantity of 1
      settings.inventory[item] = 1
    end
    "Item added successfully"
  end

  # Set the route to remove an item from the inventory
  delete '/inventory/:item' do
    item = params['item']
    # Check if the item exists in the inventory
    if settings.inventory.has_key?(item)
      # Remove the item completely if its quantity is 1
      if settings.inventory[item] == 1
        settings.inventory.delete(item)
      else
        # Decrement the quantity of the item
        settings.inventory[item] -= 1
      end
      "Item removed successfully"
    else
      "Item not found"
    end
  end

  # Set the route to update the quantity of an item in the inventory
  put '/inventory/:item/:quantity' do
    item = params['item']
    quantity = params['quantity'].to_i
    # Check if the item exists in the inventory
    if settings.inventory.has_key?(item)
      # Update the quantity of the item
      settings.inventory[item] = quantity
      "Item quantity updated successfully"
    else
      "Item not found"
    end
  end

  # Error handling for 404 Not Found
  not_found do
    content_type :json
    "{'error': 'Not Found'}"
  end

end
