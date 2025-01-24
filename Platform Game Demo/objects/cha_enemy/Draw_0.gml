draw_self()

var bar_w = 96;
var bar_h = 8;
var x1 = x-0.5*bar_w;
var y1 = y-80-bar_h;
var x2 = x1+bar_w*(HP/MAX_HP);
var y2 = y1+bar_h;
draw_rectangle(x1,y1,x2,y2,false)