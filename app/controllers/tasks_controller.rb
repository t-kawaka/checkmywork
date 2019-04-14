class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task= Task.new(task_params)
    if @task.save
      flash[:notice] = "ブログを作成しました"
      redirect_to tasks_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path
      flash[:notice] = "ブログを編集しました"
    else
      render 'new'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
    flash[:notice] = "ブログを削除しました"
  end

  private

  def task_params
    params.require(:task).permit(:name, :detail)
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
