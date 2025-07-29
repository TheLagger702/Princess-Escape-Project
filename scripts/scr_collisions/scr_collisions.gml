function scr_collisions(spd, jumpSpd){
	//Horizontal Collision
	repeat(abs(spd)){
		var signSpd = sign(spd);
		if(!place_meeting(x + signSpd, y, obj_wall)){
			x += signSpd;
		} else {
			spd = 0;
			break;
		}
	}

	//Vertical Collision
	repeat(abs(jumpSpd)){
		var signJumpSpd = sign(jumpSpd);
		if(place_meeting(x, y + signJumpSpd, obj_wall)){
			jumpSpd = 0;
			break;
		} else if (
			place_meeting(x, y + signJumpSpd, obj_onesided) && 
			!place_meeting(x, y, obj_onesided ) && 
			jumpSpd >= 0
		){
			jumpSpd = 0;
			break;
		}
		else {
			y += signJumpSpd;
		}
	}
}