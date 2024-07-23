class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course

  def toggle
    @like = @course.likes.find_by(user: current_user)
    if @like
      @like.destroy
      liked = false
    else
      @course.likes.create(user: current_user)
      liked = true
    end
    respond_to do |format|
      format.html { redirect_to @course }
      format.json { render json: { liked: liked, like_count: @course.likes.count } }
    end
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end
end
