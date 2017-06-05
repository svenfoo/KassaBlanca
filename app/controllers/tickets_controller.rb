class TicketsController < ApplicationController

  def index
    @query = params[:query] unless params[:query].blank?
    if (@query)
      if (@query.length > 2)
        @tickets = Ticket.ransack(booking_id_eq: @query,
                                  name_cont: @query,
                                  pseudonym_cont: @query,
                                  email_cont: @query,
                                  password_cont: @query,
                                  m: 'or')
                         .result(distinct: true)
      else
        @tickets = []
      end
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

  def new
    if Settings.new_ticket and Settings.new_ticket.defaults
      defaults = Settings.new_ticket.defaults.to_hash
    else
      defaults = {}
    end

    @ticket = Ticket.new(defaults)
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if Settings.new_ticket and Settings.new_ticket.check_in_after_create
      @ticket.checked_in_at = Time.now
    end

    if @ticket.save
      redirect_to @ticket
    else
      render :new
    end
  end

  def check_in_with_new
    @ticket = Ticket.create(name: "Anonymous", notes: "Checked in anonymously")
    @ticket.update_attribute(:checked_in_at, Time.now)
    redirect_to tickets_path, flash: { success: "Checked in with new ticket!" }
  end

  def check_in
    @ticket = Ticket.find(params[:ticket_id])
    @ticket.update_attribute(:checked_in_at, Time.now)
    if @ticket.role && Settings.roles[@ticket.role]
      flash_type = Settings.roles[@ticket.role].checked_in_flash_type || 'success'
      flash_message = Settings.roles[@ticket.role].checked_in_flash_message || 'Checked in successfully.'
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

  def ticket_params
    params.require(:ticket).permit(:name, :pseudonym, :email, :password, :price, :role, :notes, :created_by)
  end

end
