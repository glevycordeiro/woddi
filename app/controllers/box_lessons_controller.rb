class BoxLessonsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @box_lessons = policy_scope(BoxLesson).all
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
    raise
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
