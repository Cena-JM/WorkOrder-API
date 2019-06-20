class CreateWorkOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :work_orders do |t|
      t.text :title
      t.text :description
      t.date :deadline

      t.timestamps
    end
  end
end
