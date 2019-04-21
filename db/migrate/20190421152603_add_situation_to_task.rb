class AddSituationToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :situation, :string, default: "未着手", null: false
    add_index :tasks, :situation
  end
end
