draw_self()

if is_show_gameover {
	draw_sprite_ext(ui_dead_mask,0,0,0,1920,1080,0,c_black,0.75)
	draw_sprite(ui_dead_text,0,960,540)
}