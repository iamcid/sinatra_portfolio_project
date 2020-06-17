class CreatePartsTable < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.integer :car_id
      t.string :name
      t.string :category
    end
  end
end
