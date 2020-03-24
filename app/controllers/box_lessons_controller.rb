class BoxLessonsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @box = Box.find(params["box_id"])
    @box_lessons = policy_scope(BoxLesson).where(box: @box).where("date(box_lessons.start_date_time) = ?", Date.today).order(start_date_time: :asc)
    if params[:lesson_start] != nil && params[:lesson_start] != ""
      @box_lessons = @box_lessons.where(box: @box).where("date(box_lessons.start_date_time) = ?", params[:lesson_start].to_date)
      session[:lesson_start] = params[:lesson_start]
    else
      session[:lesson_start] = Date.today
    end
    @booking = Booking.new
  end

  def new
    @box_lesson = BoxLesson.new(status: true)
    authorize @box_lesson
  end

  def create
    @box_lesson = BoxLesson.new(box_lesson_params)
    authorize @box_lesson

    if @box_lesson.save
      redirect_to box_lessons_path
    else
      render :new
    end
    @booking = Booking.new
    @available_drop_ins = params[:capacity] - @box_lesson.booking.length
  end

  def edit
    @box_lesson = BoxLesson.find(params[:id])
  end

  def update
    @box_lesson = BoxLesson.find(params[:id])
    @box_lesson.update(params[:box_lesson])
  end

  private

  def box_lesson_params
    params.require(:box_lesson).permit(:start_date_time, :end_date_time, :box_id, :capacity, :status, :price)
  end
end
