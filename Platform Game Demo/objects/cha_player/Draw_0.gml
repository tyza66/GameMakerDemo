draw_self()

// 注意从玩家绘制的图层是和玩家的图层是一致的
if is_show_gameover {
	draw_sprite_ext(ui_dead_mask,0,0,0,1920,1080,0,c_black,0.75)
	draw_sprite(ui_dead_text,0,960,540)
}


// 除此之外,绘出UI还可以使用Draw GUI将UI绘制到镜头上