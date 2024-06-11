class TasksController < ApplicationController
  before_action :set_band, only: [:new, :create,]

  def index
    @tasks = policy_scope(Task)
  end

  def new
    @task = @band.tasks.new
    authorize @task
  end

  def create
    @task = @band.tasks.new(task_params)
    @task.band = @band
    @task.save
    redirect_to band_path(@band)
    authorize @task
  end

  def edit
    @task = Task.find(params[:id])
    @band = @task.band
    authorize @task
  end

  def update
    @task = Task.find(params[:id])
    @band = @task.band
    @task.update(task_params)
    redirect_to band_path(@band)
    authorize @task
  end

  def change_task_status
    @task = Task.find(params[:id])
    @band = @task.band
    @task.done = true
    @task.save!
    redirect_to band_path(@band, update: true)
    authorize @task
  end

  def destroy
    @task = Task.find(params[:id])
    @band = @task.band
    @task.destroy
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
