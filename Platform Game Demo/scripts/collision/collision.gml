function collide_vertical(obj){
	if place_meeting(x,y+vsp,obj){
		normal_speed = sign(vsp);
		while(not place_meeting(x,y+normal_speed,obj)){ 
			y = y+normal_speed;
		}
		vsp = 0;
	}
}

function collide_horizontal(obj){
	if place_meeting(x+hsp,y,obj){
		normal_speed = sign(hsp);
		while(not place_meeting(x+normal_speed,y,obj)){ 
			x = x+normal_speed;
		}
		hsp = 0;
	}
}


function is_on_ground(obj){
	if place_meeting(x,y+1,obj){
		return true;
	}else{
		return false;
	}
}