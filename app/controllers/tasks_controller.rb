class TasksController < ApplicationController
  before_action :set_band, only: [:new, :create]

  def index
    @tasks = policy_scope(Task)
  end

  def new
    @task = @band.tasks.new
    authorize @task
  end

  def create
    @task = @band.tasks.new(task_params)
    @task.save
    redirect_to band_path(@band)
    authorize @task
  end

  def edit
    @task = Task.find(params[:id])
    # authorize @task
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)
    @task.completed = true
    redirect_to band_path(@band)
    authorize @task
  end

  def destroy
    @task = Task.find(params[:id])
    @task.delete
    redirect_to band_path(@band)
    authorize @task
  end

  private

  def set_band
    @band = Band.find(params[:band_id])
  end

  def task_params
    params.require(:task).permit(:content, :done, :user_id)
  end
end
