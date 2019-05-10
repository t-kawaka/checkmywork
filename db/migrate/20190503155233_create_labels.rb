class CreateLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :labels do |t|
      t.string :title, null: false, limit: 30

      t.timestamps
    end
  end
end
