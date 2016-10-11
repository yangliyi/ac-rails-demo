class CreateUbikeStations < ActiveRecord::Migration[5.0]
  def change
    create_table :ubike_stations do |t|
      t.string :iid
      t.string :station
      t.text :description
      t.string :number_of_bikes

      t.timestamps
    end
  end
end
