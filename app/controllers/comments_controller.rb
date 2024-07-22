class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course
  before_action :set_comment, only: :destroy

  def create
    @comment = @course.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @course, notice: 'Comment was successfully created.'
    else
      redirect_to @course, alert: 'Unable to add comment.'
    end
  end

  def destroy
    if @comment.user == current_user
      @comment.destroy
      redirect_to @course, notice: 'Comment was successfully deleted.'
    else
      redirect_to @course, alert: 'You are not authorized to delete this comment.'
    end
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_comment
    @comment = @course.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
