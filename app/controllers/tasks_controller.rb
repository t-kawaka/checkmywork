class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    if params[:deadline]
      @tasks = Task.all.order(deadline: :desc)
    elsif params[:name] && params[:situation]
      @tasks = Task.check_name(params[:name]).check_situation(params[:situation])
    eisif params[:name] && params[:situation] == ""
      @tasks = Task.check_name(params[:name])
    elsif params[:name] == nil && params[:situation]
      @tasks = Task.check_situation(params[:situation])
    else
      @tasks = Task.all.order(created_at: :desc)
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task= Task.new(task_params)
    if @task.save
      flash[:notice] = "タスク「#{@task.name}」を作成しました"
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
      flash[:notice] = "タスク「#{@task.name}」を更新しました"
    else
      render 'new'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
    flash[:notice] = "タスク「#{@task.name}」を更新しました"
  end

  private

  def task_params
    params.require(:task).permit(:name, :detail, :deadline, :situation)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
