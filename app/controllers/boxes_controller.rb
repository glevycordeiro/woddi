class BoxesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :map]

  def index
    if params[:query].present?
      @boxes = policy_scope(Box.where("title ILIKE ?", "%#{params[:query]}%"))
    else
      @boxes = policy_scope(Box).all
    end

    @boxes = Box.geocoded #returns flats with coordinates

    @markers = @boxes.map do |box|
      {
        lat: box.latitude,
        lng: box.longitude
      }
    end
  end

  def map
    @boxes = policy_scope(Box).all
    authorize @boxes
    @boxes = Box.geocoded #returns flats with coordinates

    @markers = @boxes.map do |box|
      {
        lat: box.latitude,
        lng: box.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { box: box })
      }
    end
  end

  def show
    @booking = Booking.new
    @box = Box.find(params[:id])
    authorize @box
    if params[:search].present?
      @filtered_lessons = @box.box_lessons.where("start_date >= ? AND start_date <= ?", "%#{params[:search][:date]}%", "%#{next_day}%")
      # @hour_minutes = DateTime.filtered_lessons.strftime("%H:%M")
      # @filtered_lessons = @movie.movie_lessons.where("start_date ILIKE ?", "%#{params[:search][:date]}%")
    else
      @filtered_lessons = []
    end
    @sorted_lessons = @filtered_lessons.sort_by do |ev|
      ev.start_date.strftime("%H:%M")
    end
  end

  private

  def next_day
    user_input = params[:search][:date]
    search = Date.parse(user_input)
    day_after = (search + 1).to_s
    # method should return the day after in string format
    return day_after
  end
end
