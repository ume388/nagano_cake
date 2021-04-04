class Public::CartItemsController < ApplicationController
  
  def index
    @cart_items = current_customer.cart_items
    @total_price = @cart_items.sum{|cart_item|cart_item.item.price * cart_item.amount * 1.08}
  end
  
  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.item_id = params[:item_id]
    
    if @cart_item.save
      redirect_to cart_items_path
    else
      render 
    end
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end
  
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end
  
  def destroy_all
    @cart_item = current_customer.cart_items
    @cart_item.destroy_all
    redirect_to cart_items_path
  end

  private
  
  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id, :customer_id)
  end
  
end
