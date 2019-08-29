class TasksController < ApplicationController
before_action :authenticate_user!
  def new
    @categories = Category.all
  end

  def create
    @task = Task.new(task_params)
    @category = Category.find(category_params)
    @task.category = @category
    if @task.save
      respond_to do |format|
        format.html{ redirect_to root_path }
        format.js { }
        flash.now[:notice] = "Task created"
      end
    else
      respond_to do |format|
        format.html{ redirect_to root_path }
        format.js { }

        flash.now[:notice] = "Please try again"
      end
    end
  end

  def edit
    @task = Task.find(params[:id])
    @categories = Category.all

  end

  def update
    @task = Task.find(params[:id])
    @name = params[:name]
    @task.update(status: params[:name])

    @task.update(task_params)
    respond_to do |format|
      format.html { redirect_to '/'}
      flash[:notice] = "Task edited"
      format.js { }
    end
  end

  def index
    @tasks = Task.all
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    respond_to do |format|
      format.html{ redirect_to root_path }
      format.js { }
    end
  end


  private

  def task_params
    params.permit(:title, :deadline, :description)
  end

  def category_params
    params.require(:Category)
  end

end
