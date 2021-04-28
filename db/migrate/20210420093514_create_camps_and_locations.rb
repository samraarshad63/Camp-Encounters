class CreateCampsAndLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :camps do |t|
      t.string :camp_name
      t.date :start_date
      t.date :end_date
      t.timestamps
    end
    create_table :locations do |t|
      t.string :location_name
      t.timestamps
    end
    create_table :camps_locations, id: false do |t|
      t.belongs_to :camp
      t.belongs_to :location
    end
  end
end
