namespace :KassaBlanca do

  desc 'add fake tickets'
  task add_fake_tickets: :environment do |_t, _args|
    ActiveRecord::Base.transaction do
      1000.times do
        if rand(10) > 5
          checked_in_at = Faker::Time.backward(10)
        else
          checked_in_at = nil
        end

        t = Ticket.create(booking_id: Faker::Number.number(6),
                          name: Faker::Name.name,
                          email: Faker::Internet.email,
                          password: Faker::Internet.password,
                          price: "#{rand(100)} €",
                          checked_in_at: checked_in_at,
                          paid: Faker::Boolean.boolean(0.5),
                          notes: Faker::Hacker.say_something_smart,
                          pseudonym: Faker::Superhero.name)
        puts "Created ticket \##{t.id}"
      end
    end
  end

  desc 'add fake data for testing'
  task add_fake_data: [ :add_fake_tickets ]
end
