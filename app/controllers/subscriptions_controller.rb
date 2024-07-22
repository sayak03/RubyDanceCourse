class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course

  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = current_user.subscriptions.build(course: @course)
    if @subscription.save
      redirect_to @course, notice: 'You have successfully subscribed to this course.'
    else
      render :new
    end
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end
end
