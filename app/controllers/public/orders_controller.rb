class Public::OrdersController < ApplicationController
  
  def new
    @customer = current_customer
    @order = Order.new
  end
  
  def create
  end
  
  def index
    @orders = current_customer.orders
  end
  
  def confirm
  end

  def complete
  end
  
end
