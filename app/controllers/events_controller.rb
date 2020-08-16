class EventsController < ApplicationController
  def create
    event = Event.new(event_params)
    event.save!
    @events = Event.where(user_id: current_user.id)
  end

  def update
    event = Event.find(params[:id])
    @events = Event.where(user_id: current_user.id)
    event.update(event_params)
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    redirect_to user_event_path(current_user)
  end

  private

  def event_params
    params.require(:event).permit(:title, :start, :end, :user_id, :body, :place)
  end
end
