var dist = point_distance(returnX, returnY, obj_player.x, obj_player.y);
if(dist <= 34){
	alarm[0] = timer;
	alarm[2] = cooldown;
} else {
	x = returnX;
	y = returnY;
	alarm[2] = cooldown;
	self.image_blend = c_white;
}
