# 代码生成时间: 2025-09-06 22:26:49
# Inventory Management System using Sinatra framework
class InventoryManagement < Sinatra::Base

  # Sets up the in-memory inventory storage
  enable :sessions
  set :session_secret, 'your_secret_key'
  set :inventory, {}

  # Endpoint to display the inventory
  get '/' do
    "<html><body>#{inventory}</body></html>"
  end

  # Endpoint to add items to the inventory
  post '/add_item' do
    content_type :json
    inventory_item = params[:item]
    quantity = params[:quantity]
    if inventory_item && quantity
      if inventory[inventory_item]
        inventory[inventory_item] += quantity.to_i
      else
        inventory[inventory_item] = quantity.to_i
      end
      { success: true, message: 'Item added successfully', inventory: inventory }.to_json
    else
      { success: false, message: 'Invalid item or quantity' }.to_json
    end
  end

  # Endpoint to remove items from the inventory
  post '/remove_item' do
    content_type :json
    inventory_item = params[:item]
    quantity = params[:quantity]
    if inventory_item && quantity
      if inventory[inventory_item] && inventory[inventory_item] >= quantity.to_i
        inventory[inventory_item] -= quantity.to_i
        { success: true, message: 'Item removed successfully', inventory: inventory }.to_json
      elsif inventory[inventory_item] == 0
        { success: false, message: 'Item not found in inventory' }.to_json
      else
        { success: false, message: 'Insufficient quantity in inventory' }.to_json
      end
    else
      { success: false, message: 'Invalid item or quantity' }.to_json
    end
  end

  # Helper method to convert inventory to HTML
  helpers do
    def inventory
      inventory_list = "<ul>"
      settings.inventory.each do |item, quantity|
        inventory_list += "<li>#{item}: #{quantity}</li>"
      end
      inventory_list += "</ul>"
    end
  end

end
