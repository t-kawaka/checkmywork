class CreateLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :labels do |t|
      t.string :title, null: false, limit: 30, default: "label"

      t.timestamps
    end
  end
end
