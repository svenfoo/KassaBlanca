class TicketsController < ApplicationController
  def index
    @query = params[:query] unless params[:query].blank?
    if (@query)
      @tickets = Ticket.ransack(id_eq: @query,
                                name_cont: @query,
                                pseudonym_cont: @query,
                                email_cont: @query,
                                password_cont: @query,
                                m: 'or')
                       .result(distinct: true)
    else
      @tickets = Ticket.all
    end
  end
  def show
    @ticket = Ticket.find(params[:id])
  end
  def check_in
    @ticket = Ticket.find(params[:ticket_id])
    @ticket.checked_in_at=Time.now
    @ticket.save
    redirect_to @ticket
  end
end
