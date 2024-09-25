class RegistrationsController < ApplicationController
  before_action :require_signin, only: [ :new, :create ]
  before_action :set_event!
  def index
    @registrations = @event.registrations
  end

  def show
  end

  def new
    @registration = @event.registrations.build
  end

  def create
    @registration = @event.registrations.new(registration_params)
    @registration.user = current_user

    if @registration.save
      redirect_to @event, notice: "Registration saved successfuly!"
    else
      flash[:alert] = "Registration couldn't be saved. Try again."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_event!
    @event = Event.find_by(slug: params[:event_id])
  end

  def registration_params
    params.require(:registration).permit(
      :how_heard
    )
  end
end
