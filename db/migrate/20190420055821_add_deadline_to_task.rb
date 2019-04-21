class AddDeadlineToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :deadline, :datetime, null: false, default: DateTime.new(2019, 04, 21)
  end
end
