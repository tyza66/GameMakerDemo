// 也可以将操作输入保存到这里之后下面直接判断这些
var left = keyboard_check(ord("A"))
var right = keyboard_check(ord("D"))
var move_direction  = right - left;

var shoot = mouse_check_button(mb_left)

if place_meeting(x,y,env_door_stage2){
	if(keyboard_check_pressed(ord("E"))){
		room_goto(lev_stage_2)
	}
}

if state == "待机"{
	if is_into_state() {
		// 状态逻辑
		jump_stage = 0;
		shoot_stage = 0;
		
		if place_meeting(x,y,env_floor_oneway){
			var oneway_floor = isntance_palce(x,y,env_floor_oneway); // 这样就可以获得当前碰到的物体的id
			y = oneway_floor.y - 1;
		} // env_floor_oneway 这样获取实例的时候默认获取的是第一个
		// 我们要用instance_place获取指定的instance
	
		// 在每个状态没变就不需要切换的东西上 可以设置flag来防止反复设置执行(为每个状态机添加入口状态和出口状态)
		animation_set(anm_player)
		init_state()
	}
	
	
	
	// 状态跳转
	
	if not is_on_ground(env_floor) and not is_on_ground(env_floor_oneway){
		next_state("下落")
	}
	
	if keyboard_check(ord("A")) or keyboard_check(ord("D")){
		next_state("行走")
	}
	
	if shoot {
		next_state("射击")
		image_speed = 1;
		image_index = 0;
	}
	
	if keyboard_check_pressed(vk_space){
		if jump_stage < max_jump_stage{
			next_state("起跳")
			vsp = - jump_speed;
			jump_stage++;
		}
	}
	
	if is_leav_state(){
		get_out_state();
	}
	
}
else if state == "行走"{
	
	if is_into_state() {
		animation_set(anm_player)
		init_state()
	}
	
	
	// 行走判断
	//if (keyboard_check(ord("A"))){
	//	face_towards = -1;
	//}

	//if (keyboard_check(ord("D"))){
	//	face_towards = 1;
	//}
	
	if move_direction != 0  {
		face_towards = move_direction;
	}
	

	// 控制人物朝向
	image_xscale = face_towards

	if keyboard_check(ord("A")) or keyboard_check(ord("D")){
		// 在GML中的真是1 假是0 所以可以使用数学方法成为一种技巧
		hsp = walk_speed * face_towards;
	}else{
		// 如果没有按着左右方向行走的案件的时候
		// 这次使用一种差插值算法
		hsp = lerp(0,hsp,0.78);			
		// 一般减速的时候直接就可以进入待机状态了
	}
	
	collide_horizontal(env_floor)
	
	x += hsp;
	
	if not is_on_ground(env_floor) and not is_on_ground(env_floor_oneway){
		next_state("下落")
	}

	if  abs(hsp)<0.1{
		next_state("待机")
	}
	
	if keyboard_check_pressed(vk_space){
		if jump_stage < max_jump_stage{
			next_state("起跳")
			vsp = - jump_speed;
			jump_stage++;
		}
	}
	
	if is_leav_state(){
		get_out_state();
	}
	
}
else if state == "起跳"{
	if is_into_state() {
		init_state()
	}
	
	// 在空中也可以左右移动
	if (keyboard_check(ord("A"))){
		face_towards = -1;
	}

	if (keyboard_check(ord("D"))){
		face_towards = 1;
	}
	
	if keyboard_check(ord("A")) or keyboard_check(ord("D")){
		hsp = walk_speed * face_towards;
	}else{
		hsp = lerp(0,hsp,0.85);					
	}
	
	collide_horizontal(env_floor)
	collide_vertical(env_floor)
	
	x += hsp;
	y += vsp;
	vsp += grav;
	
	if keyboard_check_pressed(vk_space){
		if jump_stage < max_jump_stage{
			next_state("起跳")
			vsp = - jump_speed;
			jump_stage++;
		}
	}
	
	if vsp > 0{
		next_state("下落");
	}
	
	if is_leav_state(){
		get_out_state();
	}
}
else if state == "下落"{
	if is_into_state() {
		if place_meeting(x,y,env_floor_oneway){
			y = env_floor_oneway.y - 1;
		}
		init_state()
	}
	
	// 在空中也可以左右移动
	if (keyboard_check(ord("A"))){
		face_towards = -1;
	}

	if (keyboard_check(ord("D"))){
		face_towards = 1;
	}
	
	if keyboard_check(ord("A")) or keyboard_check(ord("D")){
		hsp = walk_speed * face_towards;
	}else{
		hsp = lerp(0,hsp,0.85);					
	}
	
	
	
	collide_horizontal(env_floor)
	collide_vertical(env_floor)
	collide_vertical(env_floor_oneway)
	
	x += hsp;
	y += vsp;
	vsp += grav;
	
	if is_on_ground(env_floor) or is_on_ground(env_floor_oneway){
		next_state("待机");
	}
	
	if keyboard_check_pressed(vk_space){
		if jump_stage < max_jump_stage{
			next_state("起跳");
			vsp = - jump_speed;
			jump_stage++;
		}
	}
	
	if is_leav_state(){
		get_out_state();
	}
}
else if state == "死亡"{
	if image_alpha <= -0.5{
		//room_restart();
		is_show_gameover = true;
		if keyboard_check_pressed(vk_anykey) or mouse_check_button_pressed(mb_any){
			room_restart();
		}
		
	}else{
		image_alpha -= 0.025;
	}
}
else if state == "射击"{
	if is_into_state() {
		animation_set(anm_player_shoot);
		init_state()
	}
	
	//image_index = 0; 当前帧
	//image_speed = 0; 相当于设置里的fps参数的缩放
	
	
	if shoot_stage == 0{
		if animation_at(2){
			image_speed = 0;
			image_index = 2;
		}
	
		// 因为帧数修正的值被设为0了所以不能写在上面那个if里面
		if image_index==2 && mouse_check_button_released(mb_left){
			var arrow = instance_create_layer(x,y-16,"bullet",bt_arrow);
			arrow.speed = 10;
			arrow.direction = 90 - face_towards * 90;
			//if(face_towards == 1){
			//	arrow.direction = 0;
			//}else{
			//	arrow.direction = 180;
			//}
			
			hsp = -face_towards*back_speed
			image_speed = 1;
			image_index = 3;
			shoot_stage++;
		}else{
			// 点击一瞬间就直接回待机
			if mouse_check_button_released(mb_left){
				next_state("待机");
			}
		}
	}else if  shoot_stage == 1{
		image_speed = 0;
		if abs(hsp) > 0.1 {
			hsp = lerp(0,hsp,0.8);
		}else{
			shoot_stage++;
		}
		x += hsp;
	}else if shoot_stage == 2{
		
		next_state("待机");

	}
	
	if is_leav_state(){
		get_out_state();
	}
	
}

show_debug_message(state)

if keyboard_check_pressed(vk_f5){
room_restart()
}

exit; // 这样就会跳过下面所有的代码




if is_dead{
	if image_alpha <= -0.5{
		//room_restart();
		is_show_gameover = true;
		if keyboard_check_pressed(vk_anykey) or mouse_check_button_pressed(mb_any){
			room_restart();
		}
		
	}else{
		image_alpha -= 0.025;
	}
	return
}

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
	if is_on_stage {
		acc = walk_acc;
	}else{
		acc = jump_acc;
	}
	
	
	if abs(hsp) > acc{
		hsp -= sign(hsp)*acc;
	}else{
		hsp = 0;
	}
}

if (keyboard_check_pressed(vk_space)){
	show_debug_message(+jump_stage)
	show_debug_message(max_jump_stage)
	// 游戏里面的时间单位是帧 所以这里直接省略掉乘以时间1
	if jump_stage < max_jump_stage && is_on_stage {
		vsp = -jump_speed;
		jump_stage = jump_stage + 1;
	}
}

if place_meeting(x,y+1,env_ground){
	is_on_stage = true;
	jump_stage = 0;
}else{
	is_on_stage = false;
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

if place_meeting(x,y,env_door_stage2){
	if(keyboard_check_pressed(ord("E"))){
		room_goto(lev_stage_2)
	}
}