class RemoveQuestionFromQuestion < ActiveRecord::Migration[5.1]
  def change
    remove_column :questions, :question, :text
  end
end
