class AddUserToShowtimes < ActiveRecord::Migration[5.1]
  def change
    add_reference :showtimes, :user, foreign_key: true
  end
end
