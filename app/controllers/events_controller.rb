class EventsController < ApplicationController
  before_action :logged_in_user, only: [:create,:destroy]
  before_action :correct_user, only: [:destroy]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = "Event Created!"
      redirect_to @event
    else
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def destroy
  end

  private

  def event_params
    params.require(:event).permit(:title,:location,:date,:description)
  end

  def correct_user
      @event = current_user.events.find_by(id: params[:id])
      redirect_to root_url if @event.nil?
  end
end
