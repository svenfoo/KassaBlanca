require 'csv'

#
# Export settings for WordPress EventManager
#
# Booking ID
# Name
# Email
# Total
#
# Environment variables:
#   paid:         paid flag for all tickets imported from this source
#   role:         role for all tickets imported from this source
#   created_by:   name of the import source
#   notes_column: column with notes to import

namespace :KassaBlanca do
  desc 'import data from CSV file'
  task import_csv: :environment do |_t, _args|

    paid = ENV['paid'].present?
    role = ENV['role']
    created_by = ENV['created_by']
    notes_column = ENV['notes'].present? ? ENV['notes'].to_i : 0

    i = 0

    ActiveRecord::Base.transaction do
      CSV.foreach('import.csv', return_headers: false) do |row|
        next if row[0].to_i == 0

        booking_id = row[0]
        name = row[1]
        email = row[2]
        price = row[3][1..-1].to_i
        pseudonym = row[4]
        password = row[5]
        notes = notes_column > 5 ? row[notes_column] : nil

        if t = Ticket.find_by_booking_id(booking_id)
          if t.email != email
            puts "Ticket with booking ID #{t.booking_id} exists, but with a different email address!"
          end
        else
          Ticket.create(
            booking_id: booking_id,
            name:       name,
            email:      email,
            price:      price,
            paid:       paid,
            pseudonym:  pseudonym,
            password:   password,
            role:       role,
            created_by: created_by,
            notes:      notes)
          i += 1
        end

      end
    end

    puts "Imported #{i} ticket records."
  end
end
