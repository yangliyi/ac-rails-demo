class EventsController < ApplicationController

	before_action :set_event, :only => [ :show, :edit, :update, :destroy]

	def index
	  @events = Event.page(params[:page]).per(5)
	  respond_to do |format|
	    format.html # index.html.erb
	    format.json { render :json => @events.to_json }
	    format.atom { @feed_title = "My event list" } # index.atom.builder
	  end
	end

  def latest
    @latest_events = Event.order("id DESC").limit(3)
  end

  def bulk_delete
    Event.destroy_all

    redirect_to :back
  end

	def new
		@event = Event.new
	end

	def create
  	@event = Event.new(event_params)
  	if @event.save
  		flash[:notice] = "event was successfully created"
			redirect_to events_path
  	else
    	render :action => :new
  	end
	end

	def show
  	@page_title = @event.name
  	 respond_to do |format|
	    format.html { @page_title = @event.name } # show.html.erb
	    format.json { render :json => { id: @event.id, name: @event.name }.to_json }
	  end
	end

	def edit
	end

	def update
  	if @event.update(event_params)
  		flash[:notice] = "event was successfully updated"
    	redirect_to event_path(@event)
  	else
    	render :action => :edit
  	end
	end

	def destroy
  	@event.destroy

		flash[:alert] = "event was successfully deleted"
		redirect_to events_path
	end

	private

	def event_params
  	params.require(:event).permit(:name, :description, :category_id, :group_ids => [])
	end

	def set_event
		@event = Event.find(params[:id])
	end

end
