class Public::OrdersController < ApplicationController
  
  def new
    @customer = current_customer
    @order = Order.new(order_params)
  end
  
  def create
    @order = Order.new(order_params)
    @order.save
    redirect_to complete_orders_path
    
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.order_id = @order.id
      order_detail.item_id = cart_item.item.id
      order_detail.amount = cart_item.amount
      order_detail.price = (cart_item.item.price * 1.08).round
      order_detail.save
    end
  end
  
  def index
    @orders = current_customer.orders
  end
  
  def confirm
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    @total_price = @cart_items.sum{|cart_item|cart_item.item.price * cart_item.amount * 1.08}
    
    if 0
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    else 1
      @order.postal_code =
      @order.address
      @order.name
    end
  end

  def complete
  end
  
  private
  
  def order_params
    params.permit(:postal_code, :address, :name, :total_payment)
  end
  
  def address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end
end
