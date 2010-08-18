class PomodorosController < ApplicationController
  def index
    @pomodoros = Pomodoro.all
  end
  
  def show
    @pomodoro = Pomodoro.find(params[:id])
  end
  
  def new
    @pomodoro = Pomodoro.new
  end
  
  def create
    @pomodoro = Pomodoro.new(params[:pomodoro])
    @pomodoro.user_id = current_user.id
    if @pomodoro.save
      flash[:notice] = "Successfully created pomodoro."
      redirect_to @pomodoro
    else
      render :action => 'new'
    end
  end
  
  def edit
    @pomodoro = Pomodoro.find(params[:id])
  end
  
  def update
    @pomodoro = Pomodoro.find(params[:id])
    @pomodoro.user_id = current_user.id
    if @pomodoro.update_attributes(params[:pomodoro])
      flash[:notice] = "Successfully updated pomodoro."
      redirect_to @pomodoro
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @pomodoro = Pomodoro.find(params[:id])
    @pomodoro.destroy
    flash[:notice] = "Successfully destroyed pomodoro."
    redirect_to request.env["HTTP_REFERER"]
  end
end
