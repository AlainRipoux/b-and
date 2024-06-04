class TasksController < ApplicationController
  before_action :set_band, only: [:new, :create]

  def new
    @task = @band.tasks.new
  end

  def create
    @task = @band.tasks.new(task_params)
    @task.save
    redirect_to band_path(@band)
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)
    @task.completed = true
    redirect_to band_path(@band)
  end

  def destroy
    @task = Task.find(params[:id])
    @task.delete
    redirect_to band_path(@band)
  end

  private

  def set_band
    @band = Band.find(params[:band_id])
  end

  def task_params
    params.require(:task).permit(:content, :done, :user_id)
  end
end
