class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def cart
    @cart ||= cookies[:cart].present? ? JSON.parse(cookies[:cart]) : {}
  end
  helper_method :cart

  def enhanced_cart
    @enhanced_cart ||= Product.where(id: cart.keys).map {|product| { product:product, quantity: cart[product.id.to_s] } }
  end
  helper_method :enhanced_cart

  def cart_subtotal_cents
    enhanced_cart.map {|entry| entry[:product].price_cents * entry[:quantity]}.sum
  end
  helper_method :cart_subtotal_cents

  def update_cart(new_cart)
    cookies[:cart] = {
      value: JSON.generate(new_cart),
      expires: 10.days.from_now
    }
    cookies[:cart]
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def order_items
    @order_items ||= LineItem.where(order_id: params[:id]).map{|p| {product: Product.find_by(id: p.product_id), quantity: p.quantity}}
  end
  helper_method :order_items

  def order_total
    @order_total ||= Order.find(params[:id]).total_cents
  end
  helper_method :order_total

  def product_reviews
    @product_reviews ||= Review.where(product_id: params[:id]).map{|r| {user: User.find(r.user_id).name, description: r.description, rating: r.rating}}
  end
  helper_method :product_reviews

end
