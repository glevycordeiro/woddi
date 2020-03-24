class OrdersController < ApplicationController
  def create
    box_lesson = BoxLesson.find(params[:order][:box_lesson])
    order = Order.create!(box_lesson: box_lesson, amount: box_lesson.price, state: 'pending', user: current_user)
    authorize order

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: box_lesson.title,
        amount: box_lesson.price_cents,
        currency: 'eur',
        quantity: 1
      }],
      success_url: order_url(order),
      cancel_url: order_url(order)
    )

    order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(order)
  end

  def show
    @order = current_user.orders.find(params[:id])
    authorize @order
  end
end
