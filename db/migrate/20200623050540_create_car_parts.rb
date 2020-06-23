class CreateCarParts < ActiveRecord::Migration
  def change
    create_table :car_parts do |t|
      t.integer :car_id
      t.integer :part_id
    end
  end
end
