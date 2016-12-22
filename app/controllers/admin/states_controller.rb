class Admin::StatesController < Admin::BaseController
  def index
    @states = State.all
  end

  def new
    @state = State.new
  end

  def create
    @state = State.new(state_params)
    if @state.save
      flash[:success] = 'New state created'
      redirect_to admin_states_path
    else
      flash[:error] = 'Failed to create a new state'
      render :new
    end
  end

  private

  def state_params
    params.require(:state).permit(:name)
  end
end
