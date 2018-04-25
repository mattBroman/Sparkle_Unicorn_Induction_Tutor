class AddCorrectToAttempt < ActiveRecord::Migration[5.1]
  def change
    add_column :attempts, :correct, :string
    remove_column :attempts, :proof
    add_column :attempts, :inductiveStep, :string
    add_column :attempts, :toShow, :string
  end
end
