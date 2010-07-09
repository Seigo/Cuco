# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def project_select( form )
    form.select("project_id", Project.all.collect {|p| [ p.name, p.id ] }) #, {:include_blank => 'None'}
  end
  
  def task_select( form )
    form.select("task_id", Task.all.collect {|p| [ p.name, p.id ] }) #, {:include_blank => 'None'}
  end
  
  def user_select( form )
    form.select("user_id", User.all.collect {|p| [ p.name, p.id ] }) #, {:include_blank => 'None'}
  end
  
end
