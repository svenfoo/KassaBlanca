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

        t = Ticket.new
        t.id = row[0]
        t.name = row[1]
        t.email = row[2]
        t.price = row[3][1..-1].to_i
        t.pseudonym = row[4]
        t.password = row[5]
        t.save

        i += 1
      end
    end

    puts "Imported #{i} ticket records."
  end
end
