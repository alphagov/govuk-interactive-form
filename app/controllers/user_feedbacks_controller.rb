class UserFeedbacksController < ApplicationController
  def create
    UserFeedback.create(user_feedback_params)
  end

private

  def user_feedback_params
    @items_name = params[:user_feedback][:collection]
    params.require(:user_feedback).permit(:feedback).merge(session_uuid: cookies[@items_name.to_sym])
  end
end
