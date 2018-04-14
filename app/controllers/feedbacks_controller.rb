# Feedback controller for like the post
class FeedbacksController < ApplicationController
  def like
    @pid = params[:post_id]
    return unless current_user
    a = Feedback.find_by(user_id: current_user.id, post_id: params[:post_id])
    if a.nil?
      feedback = Feedback.new
      feedback.user_id = current_user.id
      feedback.post_id = params[:post_id]
      feedback.like = true
    else
      feedback = Feedback.find(a.id)
      feedback.like = feedback.like != true
    end
    feedback.save!
    end
end
