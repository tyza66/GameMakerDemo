function is_into_state(){
	return into_state;
}

function init_state()
{
	into_state = false;
}


function is_leav_state(){
	return leave_state;
}

function get_out_state(){
	into_state = true;
	leave_state = false;
}

function next_state(next){
	state = next;
	leave_state = true;
}

