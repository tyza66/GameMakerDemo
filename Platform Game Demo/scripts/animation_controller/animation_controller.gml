function animation_at(frame_index){
	// 计算修正帧
	var fixed_frame = image_speed*(sprite_get_speed(anm_player_shoot)/game_get_speed(gamespeed_fps))
	if image_index > frame_index && image_index <= frame_index+fixed_frame {
		return true;
	}else{
		return false;
	}
}

function animation_set(animation){
	if sprite_index != animation {
		sprite_index = animation;
		image_index = 0;
		image_speed = 1;
	}
}