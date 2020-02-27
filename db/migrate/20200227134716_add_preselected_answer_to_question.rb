class AddPreselectedAnswerToQuestion < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :preselected_answer_key, :string
  end
end
