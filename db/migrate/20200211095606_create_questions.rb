class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|

      t.timestamps
      t.text :question
      t.text :content
      t.column :answers, :json
    end
  end
end
