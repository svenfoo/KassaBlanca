class AddRoleToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :role, :string
  end
end
