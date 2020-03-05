class ReviewsController < ApplicationController
  def index
    @booking = Booking.find(params[:booking_id])
    @box_lesson = @booking.box_lesson
    @reviews = policy_scope(@box_lesson.reviews)
    # Booking.find(params[:booking_id]).movie_session.movie.movie_sessions.each do |session|
    #   session.bookings.each do |booking|
    #     @reviews << booking
    #   end
    # end
  end

  def new
    @booking = Booking.find(params[:booking_id])
    @user = @booking.user
    @review = Review.new
    authorize @review
    @review.booking = @booking
  end

  def create
    @booking = Booking.find(params[:booking_id])
    @user = @booking.user
    @review = Review.new(review_params)
    @review.booking = @booking
     authorize @review
     # raise
    if @review.save
      redirect_to booking_reviews_path
    else
      flash[:alert] = "Something went wrong."
      render :new
    end
  end

  # def create
  #   @review = Review.new(review_params)
  #   @review.user = current_user
  #   if @review.save
  #     redirect_to new_review_path
  #   else
  #     flash[:alert] = "Something went wrong."
  #     render :new
  #   end
  # end

  private

  def review_params
    params.require(:review).permit(:description, :rating, :booking_id)
  end
end
