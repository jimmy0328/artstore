class Admin::OrderitemsController < AdminController

  def show
    @orders = Order.find(params[:id])
    @order_info = @orders.info
    @items = @orders.items
  end


end
