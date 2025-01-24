if mouse_over {
	if mouse_check_button(mb_left){
		if scale > 0.8 {
			scale -= 0.1
			image_xscale = scale;
			image_yscale = scale;
		}
	}else{
	if scale < 1.2 {
		scale += 0.1;
		image_xscale = scale;
		image_yscale = scale;
	}}
	
	if mouse_check_button_released(mb_left){
		game_end();
	}
	
	
}else{
	if mouse_check_button_released(mb_left){
		scale = 1
		image_xscale = scale;
		image_yscale = scale;
	}
	
	if scale > 1 {
		scale -= 0.1;
		image_xscale = scale;
		image_yscale = scale;
	} 
}