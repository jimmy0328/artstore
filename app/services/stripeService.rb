class StripeService

  def initialize(current_user,params)
    @user = current_user
    @param = params
    @order = @user.orders.find_by_token(@param[:order_id])
    @amount = @order.total * 100 # in cents
  end


  def paying!
    Stripe.api_key = Settings.stripe_apiKey
    customer = Stripe::Customer.create(
      :email => @user.email,
      :card => @param[:stripeToken]
    )
    charge = Stripe::Charge.create(
      :customer => customer.id,
      :amount => @amount,
      :description => @order.token ,
      :currency => 'usd'
    )
  rescue Stripe::CardError => e
      flash[:error] = e.message
      render "orders/pay_with_credit_card"
  end

end
