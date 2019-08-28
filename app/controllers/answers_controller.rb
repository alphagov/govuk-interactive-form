class AnswersController < ApplicationController
  def create
    Answer.create(answer_parameters)
  end

private

  def answer_parameters
    params.require(:answer).permit(:collection, :user_name, :answer, :explanation, :item_id).merge(session_uuid: session[:uuid])
  end
end
