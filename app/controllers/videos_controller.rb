# app/controllers/videos_controller.rb
class VideosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course
  before_action :set_video, only: %i[edit update destroy]
  before_action :authorize_moderator!

  def new
    @video = @course.videos.new
  end

  def create
    @video = @course.videos.new(video_params)
    if @video.save
      redirect_to @course, notice: 'Video was successfully added.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @video.update(video_params)
      redirect_to @course, notice: 'Video was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @video.destroy
    redirect_to @course, notice: 'Video was successfully deleted.'
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_video
    @video = @course.videos.find(params[:id])
  end

  def video_params
    params.require(:video).permit(:title, :url)
  end

  def authorize_moderator!
    unless current_user.has_role?(:admin) || current_user.has_role?(:moderate)
      redirect_to courses_path, alert: 'You are not authorized to perform this action.'
    end
  end
end
