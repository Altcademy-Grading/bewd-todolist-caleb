class TasksController < ApplicationController
  def index
    @tasks = Task.all
    render json: @tasks
  end

  def create
    task_params = params.require(:task).permit(:content)
    @task = Task.new(task_params)

    if @task.save
      render json: @task, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    head :no_content
  end
  
  def mark_complete
    task = Task.find(params[:id])
    task.update(completed: true)
    
  end
  
  def mark_active
    task = Task.find(params[:id])
    task.update(completed: false)
    
  end
end
