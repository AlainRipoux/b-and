class EventsController < ApplicationController
  before_action :set_band, only: [:new, :create, :edit, :update]

  def index
    @events = policy_scope(Event)
  end

  def new
    @event = @band.events.new
    authorize @event
  end

  def show
    @event = Event.find(params[:id])
    authorize @event
  end

  def create
    @event = @band.events.new(event_params)
    @event.user = current_user
    @event.band = @band
    @event.save
    authorize @event
    redirect_to event_path(@event)
  end

  def edit
    @event = Event.find(params[:id])
    @band = @event.band
    authorize @event
  end

  def update
    @event = Event.find(params[:id])
    @band = @event.band
    @event.update(event_params)
    redirect_to event_path(@event)
    authorize @event
  end

  private

  def set_band
    @band = Band.find(params[:band_id])
  end

  def event_params
    params.require(:event).permit(:name, :location, :category, :start_date, :end_date)
  end
end
