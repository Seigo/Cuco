

// Data is supposed to be an array [ {name :'', :id:0, tasks:[id:0, :name:'', description:''] }]
function require_projects_suc(data){
  if(data == null) show_error() // maybe not an error.
  else {
    //alert(data.length+" records found") // show the projects
    
    t = $('#task_tree');
    t.html("");
    $(data).each(function(i, e){
      t.append('<span class="project">' + e.name + '</span><br>');
      
      $(e.tasks).each(function(i, e){
        t.append('<span class="task" task_id="' + e.id + '">' + e.name + '</span><br>');
      })
      
    })    
  }
}

$('.task').live('click', function(){
  // live handler
  var t = $(this);
  $('#task_tree').hide();
  $("#task_name").html( t.html() );
  //$("#current_task_id").html( t.attr('task_id') );
  pomo = new Pomodoro( t.attr('task_id') );
  $("#pomodoro").show();
  // show TODO list
})

/*function show() {
  //var projects = lista de todos os projetos
  //var project = lista de tasks
  //task.duração_do_pomodoro
  //task.duração_do_break
  
  require_projects();
  //waiting
  
  
}*/

//project - lista de suas tasks
//task - qtos pomodoros tem terminados/a fazer
//pomodoro - qto tempo tem cada ciclo