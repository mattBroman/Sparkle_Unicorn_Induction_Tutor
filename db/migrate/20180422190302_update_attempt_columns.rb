class UpdateAttemptColumns < ActiveRecord::Migration[5.1]
  def change
    add_reference :attempts, :user, foreign_key: true
    add_reference :questions, :question, foreign_key: true
    add_column :attempts, :rawVal, :string
  end
end
