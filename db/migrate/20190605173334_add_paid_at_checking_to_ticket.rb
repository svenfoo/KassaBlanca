class AddPaidAtCheckingToTicket < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :paid_at_checkin, :boolean
  end
end
