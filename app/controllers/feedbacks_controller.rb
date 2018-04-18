# Feedback controller for like the post
class FeedbacksController < ApplicationController
  def like
    @pid = params[:post_id]
    return unless current_user
    feedback = current_user.feedback(@pid)
    if feedback.nil?
      feedback = Feedback.create!(user_id: current_user.id, post_id: params[:post_id], like: true)
    else
      feedback.update_attributes!(like: !feedback.like)
    end
  end
end
