require 'csv'

#
# Export settings for WordPress EventManager
#
# Booking ID
# Name
# Email
# Total
#

namespace :KassaBlanca do
  desc 'import data from CSV file'
  task import_csv: :environment do |_t, _args|

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
        role = row[6]

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
            pseudonym:  pseudonym,
            password:   password,
            role:       role)
          i += 1
        end

      end
    end

    puts "Imported #{i} ticket records."
  end
end
