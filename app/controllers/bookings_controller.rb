class BookingsController < ApplicationController
  #before_action :check_if_redeem
  def show
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.status = "active"
    @box_lesson = @booking.box_lesson
    authorize @booking
    if @booking.save
    redirect_to @booking
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
    @booking.status = "cancelled"
  end

  def cancelled
    @booking = Booking.find(params[:booking])
    authorize @booking
    @booking.status = "cancelled"
    @booking.save
    redirect_to dashboard_path, notice: "Your drop-in was cancelled"
  end

  private

  def booking_params
    params.require(:booking).permit(:user_id, :status, :box_lesson_id, :capacity, :student_first_name, :student_last_name, :student_email, :student_phone)
  end

  def check_if_redeem
    Booking.all.each do |booking|
      if booking.start_date_time > Y
        @booking.status = "redeemed"
      end
    end
  end
end
