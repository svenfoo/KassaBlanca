class AddCreatedByToTickets < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :created_by, :string
  end
end
