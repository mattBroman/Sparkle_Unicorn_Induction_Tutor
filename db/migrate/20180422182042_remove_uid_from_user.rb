class RemoveUidFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :uid, :integer
  end
end
