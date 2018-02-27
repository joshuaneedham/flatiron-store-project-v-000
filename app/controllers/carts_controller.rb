class CartsController < ApplicationController
  def show
    @current_cart = current_user.current_cart
  end

  def checkout
    @cart = Cart.find(params[:id])
    @cart.line_items.each do |line_item|
      item = Item.find(line_item.item_id)
      item.inventory -= line_item.quantity
      item.save
    end
    @cart.user.current_cart_id = nil
    @cart.user.save
    redirect_to @cart
  end
end
