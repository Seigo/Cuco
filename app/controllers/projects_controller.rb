class ProjectsController < ApplicationController
  #layout "site"
  before_filter :login
  
  
  def login
    unless current_user
      flash[:error] = "Login or create an Account First"
      redirect_to( login_url )
    end
  end
  
  # GET /projects
  # GET /projects.xml
  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end
  
  def full_graph
    @project = Project.find(params[:id])
    
    # Separete pomos which user has done on each task
    users_id = {}
    task_user_work = {}
    @tasks = @project.tasks( :order => "created_at ASC" )
    @tasks.each do |t|
       task_user_work[t.id] = {}
       t.pomodoros.each do |p|
         users_id[p.user_id] = true
         task_user_work[t.id][p.user_id] = task_user_work[t.id][p.user_id].to_i + 1
       end
    end
    data = []
    user_names = []
    users_id.each do |k,v| # use only k
      user_names.push User.find(k).username# save for the :legend
      arr = [] #data set, represents work done by user k on each task on this project
      @tasks.each do |t|
        arr.push task_user_work[t.id][k].to_i
      end
      data.push arr.reverse # why is it reversed?
    end
    
    #data = [[1,2,3,4,5], [5,4,3,2,1]]
    #prova do console: Task.first( :conditions => {:name  => 'Layout'}).pomodoros.count
    
    max = data.flatten.max*1.0
    label_x = ([0] + Array.new(9){ |i| max/9*(i+1) }).map{ |x| sprintf( "%.1f", x) }
    
    @gc = Gchart.bar(:data => data,
                     :bar_width_and_spacing => { :width => 5, :spacing => 2, :group_spacing => 12},
                     :size => '500x500',
                     :bar_colors => 'FF0000,00FF00',
                     :stacked => false, 
                     :orientation => 'horizontal',
                     :axis_with_labels => ['y', 'x'],
                     :axis_labels => [(@tasks.map &:name), label_x ], #, (0..80).to_a.join('|')
                     #:max_value => false,
                     :legend => user_names, #["User1", "User2"],
                     :custom => 'chdlp=b'
                     )
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])
    @project.user_id = current_user.id

    respond_to do |format|
      if @project.save
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to(@project) }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])
    #@project.user_id = current_user.id

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to(@project) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end
end
