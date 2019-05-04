class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    if params[:deadline]
      @tasks = current_user.tasks.expired.page(params[:page])
    elsif params[:priority]
      @tasks = current_user.tasks.priority.page(params[:page])
    elsif params[:name] && params[:situation] == ""
      @tasks = current_user.tasks.search_name(params[:name]).page(params[:page])
    elsif params[:name] == nil && params[:situation]
      @tasks = current_user.tasks.search_situation(params[:situation]).page(params[:page])
    elsif params[:name] && params[:situation]
      @tasks = current_user.tasks.search_name(params[:name]).search_situation(params[:situation]).page(params[:page])
    elsif params[:label_ids]
      @tasks = current_user.tasks.page(params[:page]).where(id: TaskLabel.where(label_id: params[:label_ids]).pluck(:task_id))
    else
      @tasks = current_user.tasks.recent.page(params[:page])
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task= current_user.tasks.new(task_params)
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
    flash[:notice] = "タスク「#{@task.name}」を削除しました"
  end

  private

  def task_params
    params.require(:task).permit(:name, :detail, :deadline, :situation, :priority, label_ids: []).merge(user_id: current_user.id)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
