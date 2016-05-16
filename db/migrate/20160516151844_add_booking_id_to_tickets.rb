class AddBookingIdToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :booking_id, :string
    add_index :tickets, :booking_id
  end
end
