class Public::OrdersController < ApplicationController
  
  def new
    @customer = current_customer
    @order = Order.new
  end
  
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.total_payment = @order.shipping_cost + calculate(current_customer)
    @order.save!
    redirect_to complete_orders_path
    
    cart_items = current_customer.cart_items
    cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.order_id = @order.id
      order_detail.item_id = cart_item.item.id
      order_detail.amount = cart_item.amount
      order_detail.price = (cart_item.item.price * 1.08).floor
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
    
    if params[:order][:address_code] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name =current_customer.last_name + current_customer.first_name
    else params[:order][:address_code] == "1"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end
  end

  def complete
  end
  
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end
  
  private
  
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_payment)
  end
  
  def address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end
  
  def calculate(customer)
    total_price = 0
    customer.cart_items.each do |cart_item|
      total_price += cart_item.amount * cart_item.item.price
    end
    return(total_price * 1.08).floor
  end
  
end
