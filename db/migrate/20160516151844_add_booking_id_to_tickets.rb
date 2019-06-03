class AddBookingIdToTickets < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :booking_id, :string
    add_index :tickets, :booking_id
  end
end
