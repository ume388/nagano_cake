class Public::OrdersController < ApplicationController
  
  def new
    @customer = current_customer
    @order = Order.new
  end
  
  def create
    @cart_items = current_customer.cart_items
  end
  
  def index
    @orders = current_customer.orders
  end
  
  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new
    @total_price = @cart_items.sum{|cart_item|cart_item.item.price * cart_item.amount * 1.08}
  end

  def complete
  end
  
end
