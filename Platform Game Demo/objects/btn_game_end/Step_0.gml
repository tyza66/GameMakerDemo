if mouse_over {
	if mouse_check_button_pressed(mb_left){
		game_end();
	}
	
	if scale < 1.2 {
		scale += 0.1;
		image_xscale = scale;
		image_yscale = scale;
	}
}else{
	if scale > 1 {
		scale -= 0.1;
		image_xscale = scale;
		image_yscale = scale;
	}
}