module TicketsHelper

  def number_of_tickets()
    return @tickets.count
  end

  def number_of_tickets_checked_in()
    return @tickets.where.not( checked_in_at: nil ).count
  end

  def number_of_tickets_checked_in_today()
    today = Time.now.beginning_of_day..Time.now.end_of_day
    return @tickets.where( checked_in_at: today ).count
  end

end
