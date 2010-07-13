class AppController < ApplicationController
  # REF's
  # STATUS http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
  # ASCII http://www.network-science.de/ascii/ (block)
  
  
  def index
    
  end
                                    
=begin
      _|_|_|    _|_|_|_|    _|_|    _|_|_|    
      _|    _|  _|        _|    _|  _|    _|  
      _|_|_|    _|_|_|    _|_|_|_|  _|    _|  
      _|    _|  _|        _|    _|  _|    _|  
      _|    _|  _|_|_|_|  _|    _|  _|_|_|    
=end
  
  def projects
    @projects = Project.all
    #@projects.each { |p| p.task_cache = p.tasks }
    
    #t = @projects.map { |p| p.tasks }
    #@tasks = {}
    #t.flatten.each{ |t| ( @tasks[t.project_id].nil? ) ? @tasks[t.project_id] = [t] : @tasks[t.project_id].push(t) }
    
    respond_to do |format|
      format.html { redirect_to :action => 'index' }
      format.js { render( :json => @projects.to_json(:only =>[:id, :name ], 
                                      :include => { :tasks => { :only => [:id, :description, :name, :overall] } })
 ) }
    end
  end
  
  def cuco
    render :layout => 'cuco_layout' 
  end
  
  def load_todo_today
    todo = TodoDay.last( :conditions => {:date => Date.parse( params[:date] ) })
    
    respond_to do |format|
      format.html { redirect_to :action => 'index' }
      format.js {   render( :json => todo.to_json) }
    end
  end
  
=begin
 _|            _| _|_|_|    _|_|_|  _|_|_|_|_|  _|_|_|_|  
  _|          _|  _|    _|    _|        _|      _|        
   _|   _|   _|   _|_|_|      _|        _|      _|_|_|    
    _|  _|  _|    _|    _|    _|        _|      _|        
      _|  _|      _|    _|  _|_|_|      _|      _|_|_|_|  

=end
  
  def save_pomodoro
    {"comment"=>"twas good", "end_time"=>"2010-07-13 16:28:20", "init_time"=>"2010-07-13 16:28:7"}
    unless ( params[:comment] && params[:task_id] && params[:init_time] && params[:end_time] && params[:i_interruption] && params[:e_interruption] )
      raise('Params missing') # if this happens means the JS failed to pass something, our error all the way. Or if war some lammer, just ignore alike. Ops.. did I just said 'alike'? -Nasty ;D
    end
    
    t = Task.find(params[:task_id])
    # Likely hack attempt, or very bad programming error :P
    raise('You User has not this task, shall not pass!') unless( t.user_id == current_user.id )
    
    p = Pomodoro.new({
                  :user_id    => current_user.id,
                  :task_id    => params[:task_id],
                  :init_time  => params[:init_time],
                  :end_time   => params[:end_time],
                  :comment    => params[:comment]
    })
    
    if p.save
      respond_to do |format|
        format.html { redirect_to :action => 'index' }
        format.js {   render( :json => ["OK"] ) }
      end
    else
      #p.errors.full_messages # ex: ["Task can't be blank", "User can't be blank", "Init time can't be blank", "End time can't be blank", "Percentage can't be blank"]
      respond_to do |format|
        format.html { redirect_to :action => 'index' }
        format.js {   render( :json => p.errors.full_messages.to_json, :status => 400 ) }
      end
    end
    
  end
  
  def save_todo_today
    unless ( params[:tasks_id] && params[:date])
      raise "params missing" # if this happens means the JS failed to pass something, our error all the way. Or if war some lammer, just ignore alike. Ops.. did I just said 'alike'? -Nasty ;D
    end
    
    #Verify if all tasks are existent
    tasks = ( Task.find( params[:tasks_id].split(','))  rescue false)
    
    unless tasks
      raise "The tasks ids passed fail to exist"
    else
      # now verify if it is not a hack and the user really has all the tasks!
      my_id = current_user.id
      raise( "Does not belong to you!") if tasks.reject { |t| t.user_id  == my_id }.size > 0 
    end
    
    p = TodoDay.new({
                  :user_id    => current_user.id,
                  :task_list => params[:tasks_id],
                  :date =>  params[:date]
    })
    
    if p.save
      respond_to do |format|
        format.html { redirect_to :action => 'index' }
        format.js {   render( :json => ["OK"] ) }
      end
    else
      # cant imagine now how anything would end here :P
      respond_to do |format|
        format.html { redirect_to :action => 'index' }
        format.js {   render( :json => p.errors.full_messages.to_json, :status => 400 ) }
      end
    end
    
  end
  
  
  
end