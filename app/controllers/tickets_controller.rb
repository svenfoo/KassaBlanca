class TicketsController < ApplicationController

  def index
    @query = params[:query] unless params[:query].blank?
    if (@query)
      @tickets = Ticket.ransack(booking_id_eq: @query,
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

  def update
    @ticket = Ticket.find(params[:id])
    @ticket.update(params[:ticket].permit(:notes))
    redirect_to @ticket
  end

  def check_in
    @ticket = Ticket.find(params[:ticket_id])
    @ticket.update_attribute(:checked_in_at, Time.now)
    if @ticket.role
      flash_type = Settings.roles[@ticket.role]&.checked_in_flash_type || 'success'
      flash_message = Settings.roles[@ticket.role]&.checked_in_flash_message || 'Checked in successfully.'
    else
      flash_type = 'success'
      flash_message = 'Checked in successfully.'
    end
    flash = {}
    flash[flash_type] = flash_message
    redirect_to @ticket , flash: flash
  end

  def check_out
    @ticket = Ticket.find(params[:ticket_id])
    @ticket.update_attribute(:checked_in_at, nil)
    redirect_to @ticket
  end

end
