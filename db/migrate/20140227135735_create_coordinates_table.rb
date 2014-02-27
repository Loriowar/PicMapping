class CreateCoordinatesTable < ActiveRecord::Migration
  def change
    create_table :coordinates do |t|
      t.integer :x_point
      t.integer :y_point
      # foreign key
      t.integer :pic_id
    end
  end
end
