class SelectedAnswersController < ApplicationController
  def create
    selected_answer = SelectedAnswer.new(selected_answer_parameters)
    if selected_answer.save
      cookies[index_key(@items_name)] = { value: params[:index].to_i + 1, expires: 2.weeks }
    end
  end

private

  def selected_answer_parameters
    @items_name = params[:selected_answer][:collection]
    answer_params = params.require(:selected_answer).permit(:collection, :user_name, :question, :answer, :explanation, :item_id).merge(session_uuid: cookies[@items_name.to_sym])
    answer_params["answer"] = answer_params["answer"] ||= "skip"
    answer_params
  end
end
