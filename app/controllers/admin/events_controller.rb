class Admin::EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_event, only: [:edit, :update, :destroy]
  layout 'backend'

  def index
    @events = Event.all
    # @consults = current_user.consults.order(created_at: :desc)
    # @q = Event.ransack(params[:q])
    # @consults = @q.result.includes(:user).page(params[:page]).per(params[:per] || 6)
  end

  def new
    @event = current_user.events.new
  end

  def create
    @event = current_user.events.new(event_params)
    @event.publish! if params[:publish]

    if @event.save
      if params[:publish]
        redirect_to admin_events_path, notice: 'Event Published Success!'
      else
        redirect_to admin_events_path, notice: 'Draft Save!'
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      case
      when params[:publish]
        @event.publish!
        redirect_to admin_events_path, notice: 'Event Published Success!'
      when params[:unpublish]
        @event.unpublish!
        redirect_to admin_events_path, notice: 'Event Unpublished Success!'
      else
        redirect_to admin_events_path, notice: 'Edit Success!'
      end
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to admin_events_path, notice: 'Event Destroy Success!'
  end

  private

  def find_event
    @event = current_user.events.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :category, :content, :status, :venue, :location, :release_date)
  end
end
