function collide_vertical(){
	if place_meeting(x,y+vsp,env_ground){
		normal_speed = sign(vsp);
		while(not place_meeting(x,y+normal_speed,env_ground)){ 
			y = y+normal_speed;
		}
		vsp = 0;
	}
}

function collide_horizontal(){
	if place_meeting(x+hsp,y,env_ground){
		normal_speed = sign(hsp);
		while(not place_meeting(x+normal_speed,y,env_ground)){ 
			x = x+normal_speed;
		}
		hsp = 0;
	}
}

function is_on_ground(){
	if place_meeting(x,y+1,env_ground){
		return true;
	}else{
		return false;
	}
}