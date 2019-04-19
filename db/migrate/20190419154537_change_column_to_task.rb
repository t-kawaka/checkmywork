class ChangeColumnToTask < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :name, :string, null: false, limit: 30
  end

  def down
    change_column :tasks, :name, :string, null: false
  end
end
