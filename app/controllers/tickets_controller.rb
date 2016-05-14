class TicketsController < ApplicationController
  def index
    @tickets=Ticket.all
  end
  def show
    @ticket=Ticket.find(params[:id])
  end
  def check_in
    @ticket=Ticket.find(params[:ticket_id])
    @ticket.checked_in_at=Time.now
    @ticket.save
    redirect_to @ticket
  end
end
