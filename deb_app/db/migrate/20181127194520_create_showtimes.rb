class CreateShowtimes < ActiveRecord::Migration[5.1]
  def change
    create_table :showtimes do |t|
      t.string :org
      t.string :town
      t.string :street
      t.string :name
      t.string :email
      t.string :phone
      t.integer :month
      t.integer :day
      t.integer :time
      t.integer :duration
      t.datetime :show_datetime
      t.integer :radio_time
      t.datetime :show_datetime_end
      t.boolean :been_update
      t.string :pic
      t.string :content

      t.timestamps
    end
  end
end
