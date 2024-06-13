class EventsController < ApplicationController
  before_action :set_band, only: [:new, :create]

  def index
    @events = policy_scope(Event)
  end

  def new
    @event = @band.events.new
    authorize @event
  end

  def show
    @event = Event.find(params[:id])
    @markers = [{
      lat: @event.latitude,
      lng: @event.longitude
    }]
    authorize @event
  end

  def create
    @event = @band.events.new(event_params)
    @event.user = current_user
    @event.band = @band
    if @event.save
      redirect_to event_path(@event)
    else
      render :new, status: :unprocessable_entity
    end
    authorize @event
  end

  def edit
    @event = Event.find(params[:id])
    @band = @event.band
    authorize @event
  end

  def update
    @event = Event.find(params[:id])
    @band = @event.band
    if @event.update(event_params)
      authorize @event
      redirect_to event_path(@event)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_band
    @band = Band.find(params[:band_id])
  end

  def event_params
    params.require(:event).permit(:name, :location, :category, :start_date, :end_date, :photo, :description, :private_event)
  end
end
