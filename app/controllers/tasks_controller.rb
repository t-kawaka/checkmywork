class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @situations = ["未着手", "着手中", "完了"]
    @priorities = {低: 0, 中: 1, 高: 2}
    @labels = Label.all
    
    @search = current_user.tasks.ransack(params[:q])
    @tasks = @search.result.recent.page(params[:page]).per(10)

    if params[:deadline]
      @tasks = current_user.tasks.expired.page(params[:page])
    end
    if params[:priority]
      @tasks = current_user.tasks.priority.page(params[:page])
    end
    if params[:label_ids]
      @tasks = current_user.tasks.page(params[:page]).where(id: TaskLabel.where(label_id: params[:label_ids]).pluck(:task_id))
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
    @task = Task.find(params[:id])
  end
end
