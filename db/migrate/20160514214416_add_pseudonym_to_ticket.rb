class AddPseudonymToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :pseudonym, :string
  end
end
