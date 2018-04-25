class CreateAttempts < ActiveRecord::Migration[5.1]
  def change
    create_table :attempts do |t|
      t.string :basis
      t.string :ih
      t.string :proof

      t.timestamps
    end
  end
end
