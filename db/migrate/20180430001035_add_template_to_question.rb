class AddTemplateToQuestion < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :template, :integer
  end
end
