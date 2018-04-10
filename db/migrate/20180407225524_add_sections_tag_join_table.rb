class AddSectionsTagJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :sections, :tags do |t|
      t.index :section_id
      t.index :tag_id
    end
  end
end
