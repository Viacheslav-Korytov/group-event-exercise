class GroupEventsController < ApplicationController
  before_action :set_group_event, only: [:show, :edit, :update, :destroy]

  # GET /group_events
  # GET /group_events.json
  def index
    @group_events = GroupEvent.where(deleted: false)
  end

  # GET /group_events/1
  # GET /group_events/1.json
  def show
  end

  # GET /group_events/new
  def new
    @group_event = GroupEvent.new
  end

  # GET /group_events/1/edit
  def edit
  end

  # POST /group_events
  # POST /group_events.json
  def create
    @group_event = GroupEvent.new(group_event_params)

    respond_to do |format|
      if @group_event.save
        format.html { redirect_to @group_event, notice: 'Group event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @group_event }
      else
        format.html { render action: 'new' }
        format.json { render json: @group_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_events/1
  # PATCH/PUT /group_events/1.json
  def update
    respond_to do |format|
      if @group_event.update(group_event_params)
        format.html { redirect_to @group_event, notice: 'Group event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @group_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_events/1
  # DELETE /group_events/1.json
  def destroy
    @group_event.destroy
    respond_to do |format|
      format.html { redirect_to group_events_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_event
      @group_event = GroupEvent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_event_params
	  begin
		json_params = ActionController::Parameters.new( JSON.parse(request.body.read) )
		return group_event_params_return(json_params)
	  rescue
		logger.error "No JSON params found"
	  end
	  group_event_params_return(params)
    end
	
	def group_event_params_return(p)
      p.require(:group_event).permit(:event_start, :event_end, :event_duration, :name, :description, :location, :published, :deleted)
	end
end
