// TODO my lib

// (new Date()).to_ruby() ex: "2010-07-07 16:12:16"
Date.prototype.to_ruby = function(){
	function _zero(num){ return ( num < 10 ) ? "0"+num : ""+num }
	return [this.getFullYear()+"", _zero(this.getMonth()+1), _zero(this.getDate()) ].join('-') + " " + 
			[this.getHours(), this.getMinutes(), this.getSeconds()].join(':')
} // d = new Date(); d.to_ruby()



// COMMON

function show_error(type, server_msg){
	
	if( typeof( type ) == undefined )	type = 999
	
	switch ( type  ){
		case 500 : alert("An server error ocurred "+type ); break;
		case 999 : alert("A comunication error has occured, try again later "+type); break;
		default  : alert("Error "+type); break;
	}
	if(server_msg) alert(server_msg)
}

/*
      _|_|_|    _|_|_|_|    _|_|    _|_|_|    
      _|    _|  _|        _|    _|  _|    _|  
      _|_|_|    _|_|_|    _|_|_|_|  _|    _|  
      _|    _|  _|        _|    _|  _|    _|  
      _|    _|  _|_|_|_|  _|    _|  _|_|_|    
*/


function require_projects(){
	j.ajax({
	  url: '/app/projects',
	  dataType: 'json',
	  cache : false,
	  success: require_projects_suc,
	  error: require_projects_err
	  //data: { page : 1 },
	})
}

/*// Data is supposed to be an array [ {name :'projectX', :id:0, tasks:[id:0, :name:'taskX', description:''] }]
function require_projects_suc(data){
	if(data == null) show_error() // maybe not an error.
	else alert(data.length+" records found") // show the projects
}*/

function require_projects_err(data){
	// data.status // 500 quando é erro do server
	show_error(data.status)
}




function require_todo_today(){
	j.ajax({
	  url: '/app/load_todo_today',
	  dataType: 'json',
	  cache : false,
	  success: require_todo_today_suc,
	  error: require_todo_today_err,
	  data: { date : (new Date).to_ruby() },
	})
}

function require_todo_today_suc(data){
	//alert("TODO list Carregada com sucesso!")
	debugger;
}

function require_todo_today_err(data, textStatus, errorThrown){
	show_error(data.status, data.responseText)
}

/*
 _|            _| _|_|_|    _|_|_|  _|_|_|_|_|  _|_|_|_|  
  _|          _|  _|    _|    _|        _|      _|        
   _|   _|   _|   _|_|_|      _|        _|      _|_|_|    
    _|  _|  _|    _|    _|    _|        _|      _|        
      _|  _|      _|    _|  _|_|_|      _|      _|_|_|_|  

*/

function save_pomodoro(init_time, end_time, task_id, i_interruption, e_interruption, comment){
	//var _init_time = new Date
	//var _end_time = new Date
	
	//_init_time.getTime
	
	j.ajax({
		url: '/app/save_pomodoro',
		dataType: 'json',
		cache : false,
		success: save_pomodoro_suc,
		error:   save_pomodoro_err,
		data: {
			comment : comment,
			task_id : task_id,
			init_time : init_time.to_ruby(),
			end_time  : end_time.to_ruby(),
			i_interruption : i_interruption, 
			e_interruption : e_interruption
		}
	})
	  //params[:comment] && params[:percentage] && params[:task_id] && params[:init_time] && params[:end_time]
}

function save_pomodoro_suc(data){
	//j("#pomo_table tbody").append("<tr><td>" + data.user_id + "</td><td>" + data.init_time + "</td><td>" + data.init_time + "</td><td>..</td><td>" + data.end_time + "</td><td>" + data.comment + "</td><td>deny</td></tr>");
	j("#pomo_table tbody").append("<tr><td><b>" + data.user + "</b></td><td>" + data.day + "</td><td>" + data.init_time + "</td><td>..</td><td>" + data.end_time + "</td><td>" + data.comment + "</td><td>Saved</td></tr>");
	alert("Pomodoro Saved Succesfuly")
}

function save_pomodoro_err(data, textStatus, errorThrown){
	show_error(data.status, data.responseText)
}





// The param expected is a list of the tasks ids, the date should be the one of when started the cicle 
function save_todo(tasks_id){
	today = new Date
	
	j.ajax({
		url: '/app/save_todo_today',
		dataType: 'json',
		cache : false,
		success: save_todo_suc,
		error:   save_todo_err,
		data: {
			date : today.to_ruby(),
			tasks_id : tasks_id.join(',')
		}
	})
}

function save_todo_suc(data){
	
	alert("TODO LIST FOI SALVA")
}

function save_todo_err(data, textStatus, errorThrown){
	show_error(data.status, data.responseText)
}
