class AddUsersSectionsJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :sections do |t|
      t.index :user_id
      t.index :section_id
    end
  end
end
