var dist = point_distance(returnX, returnY, obj_player.x, obj_player.y);
if(dist <= 34){
	alarm[0] = timer;
} else {
	x = returnX;
	y = returnY;
	self.image_blend = c_white;
}
