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

  def make_default
    state = State.find(params[:id])
    true_state = State.find_by(default: true)
    if state != true_state
      # find ways to replace following 2 separate db calls by 1 call
      state.update!(default: true)
      true_state.update!(default: false)
    end
    redirect_to admin_states_path
  end

  private

  def state_params
    params.require(:state).permit(:name)
  end
end
