module SelectedAnswersHelper

  def present_answers(item)
    item["answers"].each_with_object([]) do |answer, presented_answers|
      presented_answers << {
        value: answer['key'],
        text: answer['text'].html_safe,
        checked: answer['key'] == item['preselected_answer_key']
      }
    end
  end
end
