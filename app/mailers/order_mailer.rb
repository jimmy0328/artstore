class OrderMailer < ActionMailer::Base
  default from: "jimmy0328@gmail.com"

  def notify_order_placed(order)
     @order = order
     @user = order.user
     @order_items = @order.items 
     @order_info = @order.info 
     mail(to: @user.email, subject: "[Jimmy Store] 非常感謝你本次的消費，以下是您這次的購物明細 #{order.token}")

  end

  def notify_payment(order)
    @order = order
    @user = order.user
    mail(to: @user.email, subject: "[Jimmy Store] 刷卡完成通知")    
  end

end
