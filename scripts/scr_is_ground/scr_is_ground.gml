function scr_is_ground(px, py, jumpSpd){
	if(place_meeting(px, py +1, obj_wall)) {
		return true;
	}
	else if (place_meeting(px, py +1, obj_onesided) && !place_meeting(px, py, obj_onesided)){
		if( jumpSpd >= 0) return true;
		else return false;
	}
	return false;
}