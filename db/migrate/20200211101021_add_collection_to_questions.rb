class AddCollectionToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :collection, :string
  end
end
