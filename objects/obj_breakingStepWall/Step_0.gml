if(place_meeting(x, y -1, obj_entity) && alarm[0] == -1 && alarm[2] == -1){
	alarm[0] = timer;
	self.image_blend = c_ltgray;
}

if(breaking){
	y = fallingLimit;
}

if(y == fallingLimit) {
	if(breaking){
		breaking = false;
		alarm[1] = cooldown * 2;
	}
}

//if(global.resetRoom){
//	alarm[1] = 0;
//}