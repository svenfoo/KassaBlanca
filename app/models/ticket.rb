class Ticket < ActiveRecord::Base

  scope :checked_in, -> { where.not(checked_in_at: nil) }
  scope :checked_in_today, -> { where(checked_in_at: Time.now.beginning_of_day..Time.now.end_of_day) }

end
