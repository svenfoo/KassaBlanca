class AddPseudonymToTicket < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :pseudonym, :string
  end
end
