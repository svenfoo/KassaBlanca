class AddRoleToTickets < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :role, :string
  end
end
