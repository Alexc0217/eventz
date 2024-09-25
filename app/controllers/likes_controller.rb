class LikesController < ApplicationController
  before_action :require_signin

  def create
    @event = Event.find_by(slug: params[:event_id])
    @likes = @event.likes.create!(user: current_user)

    redirect_to @event
  end

  def destroy
    event = Event.find_by(slug: params[:event_id])
    like = current_user.likes.find params[:id]
    like.destroy

    redirect_to event
  end
end
