class ChangeDeadlineToTasks < ActiveRecord::Migration[5.2]
  def up
   change_column_null :tasks, :deadline, null: false
 end

 def self.down
   change_column_null :tasks, :deadline, null: true
 end
end
