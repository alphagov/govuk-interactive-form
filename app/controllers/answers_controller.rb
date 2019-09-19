class AnswersController < ApplicationController
  def create
    answer = Answer.new(answer_parameters)
    if answer.save
      cookies[index_key(@items_name)] = { value: params[:index].to_i + 1, expires: 2.weeks }
    end
  end

private

  def answer_parameters
    @items_name = params[:answer][:collection]
    answer_params = params.require(:answer).permit(:collection, :user_name, :question, :answer, :explanation, :item_id).merge(session_uuid: cookies[@items_name.to_sym])
    answer_params["answer"] = answer_params["answer"] ||= "skip"
    answer_params
  end
end
