class TasksController < ApplicationController
  def index
    @tasks = Task.all
    render 'tasks/index'
  end

  def create
    task_params = params.require(:task).permit(:content)
    @task = Task.new(task_params)

    if @task.save!
      render 'tasks/create', status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    task = Task.find(params[:id])

    if task.destroy
      render json: { success: true }
    else
      head :no_content
    end
  end

  def mark_complete
    @task = Task.find(params[:id])
    @task.update(completed: true)

    render 'tasks/show'
  end

  def mark_active
    @task = Task.find(params[:id])
    @task.update(completed: false)

    render 'tasks/show'
  end
end
