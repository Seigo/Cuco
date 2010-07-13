class TodoDaysController < ApplicationController
  def index
    @todo_days = TodoDay.all
  end
  
  def show
    @todo_day = TodoDay.find(params[:id])
  end
  
  def new
    @todo_day = TodoDay.new
  end
  
  def create
    @todo_day = TodoDay.new(params[:todo_day])
    if @todo_day.save
      flash[:notice] = "Successfully created todo day."
      redirect_to @todo_day
    else
      render :action => 'new'
    end
  end
  
  def edit
    @todo_day = TodoDay.find(params[:id])
  end
  
  def update
    @todo_day = TodoDay.find(params[:id])
    if @todo_day.update_attributes(params[:todo_day])
      flash[:notice] = "Successfully updated todo day."
      redirect_to @todo_day
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @todo_day = TodoDay.find(params[:id])
    @todo_day.destroy
    flash[:notice] = "Successfully destroyed todo day."
    redirect_to todo_days_url
  end
end
