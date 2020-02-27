class CreateSelectedAnswers < ActiveRecord::Migration[5.2]
  def change
    rename_table :answers, :selected_answers
  end
end
