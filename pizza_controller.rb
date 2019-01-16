require('sinatra')
require('sinatra/reloader') if development?
require('pry-byebug')
also_reload('./models/*')
require_relative('./models/pizza_order')

get '/' do
  erb(:home)
end

# INDEX
get '/pizza_orders' do
  # Go to the database and retrieve all the orders
  @orders = PizzaOrder.all()
  # Display a list of all the orders
  erb(:index)
end

# NEW
get '/pizza_orders/new' do
  erb(:new)
end
# CREATE
post '/pizza_orders' do
  # Create a new PizzaOrder object
  # Save it to the DB
  PizzaOrder.new(params).save()
  # Redirect browser to '/pizza_orders'
  redirect to '/pizza_orders'
end
# SHOW
get '/pizza_orders/:id' do
  # Go to the database and retrieve one specific order (by id)
  @order = PizzaOrder.find(params[:id])
  # Display the order
  erb(:show)
end

# EDIT
get '/pizza_orders/:id/edit' do
  @edit_order = PizzaOrder.find(params[:id])
  erb(:edit)
end
# UPDATE
put '/pizza_orders/:id' do
  @editted_order = PizzaOrder.find(params[:id])
  @editted_order.first_name = params[:first_name]
  @editted_order.last_name = params[:last_name]
  @editted_order.quantity = params[:quantity]
  @editted_order.topping = params[:topping]
  @editted_order.update()
  redirect to '/pizza_orders'
end

# DESTROY
delete '/pizza_orders/:id' do
  @delete_order = PizzaOrder.find(params[:id])
  @delete_order.delete()
  redirect to '/pizza_orders'
end
