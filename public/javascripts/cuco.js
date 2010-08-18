function ProgressBar(pomodoro, pomodoro_size){
  var instance = this;
  instance.pomodoro=pomodoro;
  instance.pomo_size=pomodoro_size * 60 * 1000; // em milisec
  //instance.um_por_cento_do_pomodoro_size = instance.pomo_size * 600; //(pomodoro_size * 60 * 1000) / 100
  instance.um_por_cento_do_pomodoro_size = instance.pomo_size / 100;
  instance.time_elapsed = 0;
  var t;
  
  $("#progressbar").progressbar({value: instance.time_elapsed});
  $("#timer").html(instance.pomo_size/60000);
  
  function progressIncrement(){
  
    $("#progressbar").progressbar("option", "value", instance.time_elapsed);
    $("#timer").html((instance.pomo_size - (instance.time_elapsed * instance.um_por_cento_do_pomodoro_size))/60000)
    instance.time_elapsed += 1;
    
    if (instance.time_elapsed < 101) { // ainda não completou o pomodoro
      t = setTimeout("pomo.progressBar.progressIncrement()", instance.um_por_cento_do_pomodoro_size); //
    }
    else { // pomodoro finished!
    //debugger
      instance.pomodoro.finished();
    }
  }
  function start(){
    progressIncrement();
  }
  function stop(){
    clearTimeout(t);
    $("#progressbar").progressbar("option", "value", 0);
    $("#timer").html(instance.pomo_size/60000);
  }
  
  instance.start=start;
  instance.stop=stop;
  instance.progressIncrement = progressIncrement;
}

function Pomodoro( task_id, embedded ) { // estados possíveis: // "parado", "trabalhando", "fim_trabalho", "intervalo", "fim_intervalo", "cucos_gone_mad"
  var instance = this;
	instance.task_id = task_id
  instance.progressBar = null;
  instance.status = "parado";
  instance.pomodoro_duration = 1; //minutos
  instance.break_duration = 5.0; //minutos
  instance.embedded = (typeof(embedded) == 'undefined') ? false : embedded
  
	instance.init_time = null;
	instance.end_time = null;
  
  function cuco_click() {
    if(instance.status == "parado") { // tava parado, começou a trampar
      $("#cuco_balloon").html("<p>Working..</p>");
      start_work();
    }
    else if(instance.status == "trabalhando") { // clicou qdo estava no meio do pomodoro
      stop_pomodoro();
    }
    else if(instance.status == "fim_trabalho") { // clicou para começar o break
      $("#cuco_balloon").html("<p>Breaking(?)..</p>");
      start_break();
    }
    else if(instance.status == "intervalo") { // clicou qdo estava no meio do pomodoro
      stop_pomodoro();
    }
    else if(instance.status == "fim_intervalo") { // clicou para começar a trabalhar
      $("#cuco_balloon").html("<p>Working..</p>");
      start_work();
    }
    else {
      $("#cuco_balloon").html("<p>I don't know this option!</p>");
      instance.status = "cucos_gone_mad!";
    }
  }
  function finished() {
    if(instance.status == "trabalhando") {
      instance.status = "fim_trabalho";
			instance.end_time = new Date()
      $("#cuco_balloon").html("<p>You worked enough. Take a break!</p>");
			instance.comment = prompt("Any comment to record on this Pomodoro?", "")
			save_pomodoro( instance.init_time, instance.end_time, instance.task_id,
										 0, 0, instance.comment)
    }
    else if(instance.status == "intervalo") {
      $("#cuco_balloon").html("<p>Idle time is over. Let's get back to work!</p>");
      alert("Back to work!");
      instance.status = "fim_intervalo";
    }
    else {
      $("#cuco_balloon").html("<p>Something's gone very wrong! How progress finished while stopped?? o_o</p>");
      instance.status = "cucos_gone_mad!";
    }
  }
  function stop_pomodoro() {
    instance.progressBar.stop();
    $("#cuco_balloon").html("<p>Cuco is now asleep..</p>");
    instance.status = "parado";
    if( instance.embedded ){
		pomo = new Pomodoro(instance.task_id, instance.embedded)
	}else{
		$("#pomodoro").hide();
		// retornar dados sobre os pomodoros?
		require_projects();
		$('#task_tree').show();
	}
  }
  function start_work() {
    instance.progressBar = new ProgressBar(instance, instance.pomodoro_duration);
    instance.progressBar.start();
    instance.status = "trabalhando";
		instance.init_time = new Date();
  }
  function start_break() {
    instance.progressBar = new ProgressBar(instance, instance.break_duration);
    instance.progressBar.start();
    instance.status = "intervalo";
  }
  
  instance.cuco_click=cuco_click;
  instance.stop_pomodoro=stop_pomodoro;
  instance.start_work=start_work;
  instance.start_break=start_break;
  instance.finished = finished 
}

function ToDoSheet() {
  
}
