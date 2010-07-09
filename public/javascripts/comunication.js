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

// Data is supposed to be an array [ {name :'', :id:0, tasks:[id:0, :name:'', description:''] }]
function require_projects_suc(data){
	if(data == null) show_error() // maybe not an error.
	else alert(data.length+" records found") // show the projects
}

function require_projects_err(data){
	// data.status // 500 quando é erro do server
	show_error(data.status)
}




/*
 _|            _| _|_|_|    _|_|_|  _|_|_|_|_|  _|_|_|_|  
  _|          _|  _|    _|    _|        _|      _|        
   _|   _|   _|   _|_|_|      _|        _|      _|_|_|    
    _|  _|  _|    _|    _|    _|        _|      _|        
      _|  _|      _|    _|  _|_|_|      _|      _|_|_|_|  

*/

function save_pomodoro(){
	var _init_time = new Date
	var _end_time = new Date
	
	_init_time.getTime
	
	j.ajax({
		url: '/app/save_pomodoro',
		dataType: 'json',
		cache : false,
		success: save_pomodoro_suc,
		error:   save_pomodoro_err,
		data: {
			comment : "",
			percentage : 100,
			task_id : 5,
			init_time : _init_time.to_ruby(),
			end_time  : _end_time.to_ruby()	
		}
	})
	  //params[:comment] && params[:percentage] && params[:task_id] && params[:init_time] && params[:end_time]
}

function save_pomodoro_suc(data){
	alert("Pomodoro Saved Succesfuly")
}

function save_pomodoro_err(data, textStatus, errorThrown){
	show_error(data.status, data.responseText)
}

