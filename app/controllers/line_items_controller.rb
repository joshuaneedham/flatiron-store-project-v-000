class LineItemsController < ApplicationController
  def create
    current_user.current_cart = current_user.current_cart || current_user.carts.create
    item = Item.find(params[:item_id])
    line_item = current_user.current_cart.add_item(Item.find(params[:item_id]).id)

    #if its an exisiting line item, add one to it
    if line_item.id
      line_item.quantity += 1
    end
    #if not just save it
    line_item.save
    redirect_to current_user.current_cart
  end
end
