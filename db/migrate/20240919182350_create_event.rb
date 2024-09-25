class CreateEvent < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :name
      t.string :location
      t.decimal :price
      t.timestamps
    end
  end
end
