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
// 在本引擎中 表面刚刚接触并不算碰撞,只有当两个物体有重叠部分的时候才算碰撞
// 如果想实现精准判定应该使用预碰撞机制

//if (keyboard_check(vk_up)){
//	y -= walk_speed
//}

//if (keyboard_check(vk_down)){
//	y += walk_speed
//}

// 在判定之前进行碰撞预判断
if place_meeting(x,y+vsp,env_ground){
	
	normal_speed = vsp/abs(vsp) // 如果是＋1就是朝下 如果是-1就是朝上
	
	// 如果下一帧根地板相撞了 但是位置还没有到达地板上 就会出现人物悬停
	// 但是这里我们要考虑到如果玩家在方块下面 头撞到了方块上
	// 我们要使用一种递归的方式来解决这种问题 就是循环检测一下到底触底了吗
	// 如果不是还有一个像素就接触的话,角色位置就向下移动一个像素 一直走到差一个像素的地方
	while(not place_meeting(x,y+normal_speed,env_ground)){ // 这是一种弱语法语言 条件的地方可以没有括号
		y = y+normal_speed;
	}
	vsp = 0;
	
}


y = y + vsp;
vsp = vsp + grav;

