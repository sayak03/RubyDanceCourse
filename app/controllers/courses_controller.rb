class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: %i[show edit update destroy]

  def index
    @courses = Course.all
  end

  def show
    if current_user.has_role?(:admin) || current_user.has_role?(:moderate) || current_user.subscribed?(@course)
      @content = @course
    else
      @content = @course.slice(:title)
    end
  end

  def new
    authorize_moderator!
    @course = Course.new
  end

  def create
    authorize_moderator!
    @course = Course.new(course_params)
    if @course.save
      redirect_to @course, notice: 'Course was successfully created.'
    else
      render :new
    end
  end

  def edit
    authorize_moderator!
  end

  def update
    authorize_moderator!
    if @course.update(course_params)
      redirect_to @course, notice: 'Course was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize_moderator!
    @course.destroy
    redirect_to courses_url, notice: 'Course was successfully destroyed.'
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description)
  end

  def authorize_moderator!
    unless current_user.has_role?(:admin) || current_user.has_role?(:moderate)
      redirect_to courses_path, alert: 'You are not authorized to perform this action.'
    end
  end
end
