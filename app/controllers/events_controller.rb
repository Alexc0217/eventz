class EventsController < ApplicationController
  before_action :require_signin, except: [ :index, :show ]
  before_action :require_admin, except: [ :index, :show ]
  before_action :set_event, except: [ :index, :new, :create ]
  def index
    case params[:filter]
    when "past"
      @events = Event.past
    when "recent"
      @events = Event.recent
    when "free"
      @events = Event.free
    else
      @events = Event.upcoming
    end
  end

  def new
    @event = Event.new
  end

  def show
    @likers = @event.likers
    @categories = @event.categories
    if current_user
      @like = current_user.likes.find_by(event_id: @event.id)
    end
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      flash[:notice] = "Event successfully created!"
      redirect_to @event
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if event.destroy
      flash[:notice] = "Event successfully deleted!"
      redirect_to events_path, message: "Success!"
    else
      redirect_to event
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      flash[:notice] = "Event successfully updated!"
      redirect_to event_path(@event)
    else
      flash[:alert] = "Event couldn't be saved."
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_event
    @event = Event.find_by!(slug: params[:id])
  end

  def event_params
    params.require(:event).permit(
      :id,
      :name,
      :description,
      :location,
      :price,
      :starts_at,
      :capacity,
      :image_file_name,
      category_ids: []
    )
  end
end
