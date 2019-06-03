class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.string :email
      t.string :name
      t.string :password
      t.integer :price
      t.boolean :paid, null: false, default: false
      t.datetime :checked_in_at
      t.text :notes

      t.timestamps null: false
    end
  end
end
