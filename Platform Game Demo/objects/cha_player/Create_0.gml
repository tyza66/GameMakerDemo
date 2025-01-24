// Create是创建的时间节点 可以用来做一些初始化的操作
// 控制台输出debug信息
show_debug_message("这是一条控制台消息，当前创建了玩家对象")
// 坐标原点位于左上角 修改x和y的值就是修改当前对象的值
// x = 0;
// y = 0;
walk_speed = 3;
jump_speed = 15;
back_speed = 15;
acc = 0.5;
walk_acc = 1.5;
jump_acc = 0.3;
normal_speed = 0; // 用于判断当前玩家的方向
hsp = 0; // 用于存储水平方向的速度
vsp = 0; // 这是用于手动实现重力的垂直速度

grav = 0.7;

jump_stage= 0;
max_jump_stage= 1;
is_on_stage = false;

is_dead = false;
is_show_gameover = false;

// 我们可以手动实现状态机
state = "待机";

// 人物朝向
face_towards = 1;

shoot_stage = 0;

into_state = true
leave_state = false

can_pass = false;