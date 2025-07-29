if(place_meeting(x, y -1, obj_entity) && alarm[0] == -1 && alarm[2] == -1){
	alarm[0] = timer;
	self.image_blend = c_ltgray;
}

if(!fall){
	fallingSpd = 0;
}
else {
	fallingSpd = scr_approach(fallingSpd, fallingMaxSpd, gravityNorm);
}

if(y < fallingLimit) y += fallingSpd;
else {
	if(fall){
		fall = false;
		alarm[1] = timer;
	}
}

//if(global.resetRoom){
//	alarm[1] = 0;
//}