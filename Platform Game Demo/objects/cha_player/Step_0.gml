// Step是每一帧的时间节点
// 设置中设置了默认每秒是60帧 那就是说默认会每秒执行60下

// 要用字母按键的话就用ord("W") 注意里面是大写字母 如果是键盘上面除了字母的按键vk_left
if (keyboard_check(ord("A"))){
	hsp = -walk_speed;
}

if (keyboard_check(ord("D"))){
	hsp = walk_speed;
}

if (not keyboard_check(ord("A"))) && ( not (keyboard_check(ord("D")))){
	hsp = 0;
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
if place_meeting(x+hsp,y,env_ground){
	
	// sign方法可以将变量进行标准化 对任何变量都可以取成 -1\+1\0
	normal_speed = sign(hsp) // 如果是＋1就是朝下 如果是-1就是朝上
	
	// 如果下一帧根地板相撞了 但是位置还没有到达地板上 就会出现人物悬停
	// 但是这里我们要考虑到如果玩家在方块下面 头撞到了方块上
	// 我们要使用一种递归的方式来解决这种问题 就是循环检测一下到底触底了吗
	// 如果不是还有一个像素就接触的话,角色位置就向下移动一个像素 一直走到差一个像素的地方
	while(not place_meeting(x+normal_speed,y,env_ground)){ // 这是一种弱语法语言 条件的地方可以没有括号
		x = x+normal_speed;
	}
	hsp = 0;
	
}

if place_meeting(x,y+vsp,env_ground){
	
	// sign方法可以将变量进行标准化 对任何变量都可以取成 -1\+1\0
	normal_speed = sign(vsp) // 如果是＋1就是朝下 如果是-1就是朝上
	
	// 如果下一帧根地板相撞了 但是位置还没有到达地板上 就会出现人物悬停
	// 但是这里我们要考虑到如果玩家在方块下面 头撞到了方块上
	// 我们要使用一种递归的方式来解决这种问题 就是循环检测一下到底触底了吗
	// 如果不是还有一个像素就接触的话,角色位置就向下移动一个像素 一直走到差一个像素的地方
	while(not place_meeting(x,y+normal_speed,env_ground)){ // 这是一种弱语法语言 条件的地方可以没有括号
		y = y+normal_speed;
	}
	vsp = 0;
	
}


x += hsp;
y = y + vsp;
vsp = vsp + grav;

// 介绍一下三种变量类型
// x,y 这种绿色的变量叫做build-in variable 中文名叫内置变量
// 内置变量本身含有设置好的功能和数据接口
// image_alpha表示不透明度

// 第二种叫做instance variable 实例变量
// Object是一切Instance的母本 在游戏运行的时候是不存在Object的
// 游戏运行的时候所有的交互物体都是Instance object_index能读取到Instance母本的名字
// 在游戏中创建instance的时候我们调用的是instance_create方法
// 所说的示例变量就是挂载在实例上面的变量 只有在当前的示例中才可以直接访问到
// 如果想访问别的实例的实例变量 直接用cha_player.xxx 这样直接点到就行了

// 大部分的内置变量和实例变量的作用域是一样的

// 还有一种叫做local variable 本地变量 作用域是当前代码块
// 在本地变量前面需要加声明语句var 例如 var a = 1;
// 本地变量的作用域对事件也是起作用的

// 其实除了那些以外还有一种全局变量 作用域是全局
global.myGlobalVariable = 96;