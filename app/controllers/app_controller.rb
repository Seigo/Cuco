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
    asdsads
    
    respond_to do |format|
      format.html { redirect_to :action => 'index' }
      format.js { render( :json => @projects.to_json) }
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
    
    unless ( params[:comment] && params[:percentage] && params[:task_id] && params[:init_time] && params[:end_time] )
      trigger.fucking.error.from.moon # if this happens means the JS failed to pass something, our error all the way. Or if war some lammer, just ignore alike. Ops.. did I just said 'alike'? -Nasty ;D
    end
    
    t = Task.find(params[:task_id])
    # Likely hack attempt, or very bad programming error :P
    trigger.fucking.error.from.moon unless( t.user_id == current_user.id )
    
    p = Pomodoro.new({
                  :user_id    => current_user.id,
                  :task_id    => params[:task_id],
                  :init_time  => params[:init_time],
                  :end_time   => params[:end_time],
                  :comment    => params[:comment],
                  :percentage => params[:percentage]
    })
    
    if p.save
      respond_to do |format|
        format.html { redirect_to :action => 'index' }
        format.js {   render( :json => "OK" ) }
      end
    else
      #p.errors.full_messages # ex: ["Task can't be blank", "User can't be blank", "Init time can't be blank", "End time can't be blank", "Percentage can't be blank"]
      respond_to do |format|
        format.html { redirect_to :action => 'index' }
        format.js {   render( :json => p.errors.full_messages.to_json, :status => 400 ) }
      end
    end
    
  end
  
end