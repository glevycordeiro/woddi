class BookingsController < ApplicationController
  #before_action :check_if_redeem

  def index
    @bookings = policy_scope(Booking).where(user: current_user).includes(:box_lesson).order("box_lessons.start_date_time")
    @review = Review.new
  end

  def show
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.status = "Active"
    @box_lesson = BoxLesson.find(booking_params[:box_lesson_id])
    @booking.box_lesson = @box_lesson
    authorize @booking
    if @booking.save
    redirect_to bookings_path(@booking)
    # flash[:alert] = "Booking sucessful"
    else
      flash[:notice] = "The number of drop-ins requested is not available. There are only #{@booking.box_lesson.capacity - @booking.capacity} drop-ins available."
      redirect_to @box
      #render 'movies/show'
    end
  end

  def edit
    @bookings = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.status = "Cancelled"
  end

  def cancelled
    @booking = Booking.find(params[:booking])
    authorize @booking
    @booking.status = "Cancelled"
    @booking.save
    redirect_to bookings_path, notice: "Your drop-in was cancelled"
    destroy
  end

  def destroy
    @booking = Booking.find(params[:booking])
    @booking.destroy
  end

  private

  def booking_params
    params.require(:booking).permit(:user_id, :status, :box_lesson_id, :capacity, :student_first_name, :student_last_name, :student_email, :student_phone)
  end

  def check_if_redeem
    Booking.all.each do |booking|
      if booking.start_date_time > Y
        @booking.status = "Checked-in"
      end
    end
  end
end
