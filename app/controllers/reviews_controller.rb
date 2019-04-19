class ReviewsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to @product
    else
      render @product
    end
  end

  def review_params
    params.require(:review).permit(:description, :rating)
  end

end
