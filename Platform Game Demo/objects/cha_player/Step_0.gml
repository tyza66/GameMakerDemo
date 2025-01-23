// Step是每一帧的时间节点
// 设置中设置了默认每秒是60帧 那就是说默认会每秒执行60下

// 要用字母按键的话就用ord("W") 注意里面是大写字母 如果是键盘上面除了字母的按键vk_left
if (keyboard_check(ord("A"))){
	x -= walk_speed;
}

if (keyboard_check(ord("D"))){
	x += walk_speed;
}

if (keyboard_check(vk_space)){
	vsp = -jump_speed;
}

// 在这个引擎中,碰撞体是和图片绑定在一起的,如果想实现碰撞效果,需要先给对象新增以一个图片

//if (keyboard_check(vk_up)){
//	y -= walk_speed
//}

//if (keyboard_check(vk_down)){
//	y += walk_speed
//}

y = y + vsp;
vsp = vsp + grav;