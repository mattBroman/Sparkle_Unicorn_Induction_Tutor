class NoMoreMigrations < ActiveRecord::Migration[5.1]
  def change
    add_reference :attempts, :question, foreign_key: true
  end
end
