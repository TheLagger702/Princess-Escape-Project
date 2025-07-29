var moveX		= lengthdir_x(spd, dir);
var moveY		= lengthdir_y(spd, dir);
x += moveX;
y += moveY;
	
if(image_index == damageImage){
	damage = damageReal;
}else{
	damage = 0;
}

if (x < 0 || x > room_width || y < 0 || y > room_height) {
    instance_destroy();
}