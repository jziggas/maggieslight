class PageFeedbacksController < ApplicationController

  def create
    @page_feedback = current_user.page_feedbacks.build( page_feedback_params )
    if @page_feedback.save!
      redirect_to({controller: @page_feedback.controller, action: @page_feedback.action}, notice: "Thank you for your feedback")
    else
      redirect_to care_receiver_profiles_path, notice: "There was an error."
    end
  end

  private

  def page_feedback_params
    params.require(:page_feedback).permit(:feedback, :controller, :action)
  end
end