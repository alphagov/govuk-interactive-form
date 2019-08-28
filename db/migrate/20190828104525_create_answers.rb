class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.string :collection
      t.string :session_uuid
      t.string :user_name
      t.string :answer
      t.text :explanation
      t.string :question
      t.string :item_id
      t.timestamps
    end
  end
end
