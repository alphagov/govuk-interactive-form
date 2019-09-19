class CreateUserFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :user_feedbacks do |t|

      t.timestamps
      t.text :feedback
      t.string :session_uuid
    end
  end
end
