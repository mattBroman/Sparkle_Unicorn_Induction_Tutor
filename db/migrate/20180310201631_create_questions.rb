class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.text :question
      t.string :p_k
      t.string :implies

      t.timestamps
    end
  end
end
