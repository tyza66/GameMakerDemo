// Step是每一帧的时间节点
// 设置中设置了默认每秒是60帧 那就是说默认会每秒执行60下

// 要用字母按键的话就用ord("W") 注意里面是大写字母
if (keyboard_check(vk_left)){
	x -= walk_speed
}

if (keyboard_check(vk_right)){
	x += walk_speed
}

//if (keyboard_check(vk_up)){
//	y -= walk_speed
//}

//if (keyboard_check(vk_down)){
//	y += walk_speed
//}