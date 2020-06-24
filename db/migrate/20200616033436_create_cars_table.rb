class CreateCarsTable < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.integer :user_id
      t.integer :year
      t.string :make
      t.string :model
      t.string :color
      t.string :parts
    end
  end
end
