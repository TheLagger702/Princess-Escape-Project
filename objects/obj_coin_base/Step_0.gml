//Boolean Collisions
collisionLeft	= place_meeting(x -1, y   , obj_wall);
collisionRight	= place_meeting(x +1, y   , obj_wall);
collisionUp     = place_meeting(x   , y -1, obj_wall);
isGrounded		= scr_is_ground(x	, y   , jumpSpd);

if(movement !=0 && isGrounded){
	movement *= movement * 0.75;
}

//Define acceleration and friction from the enviroment
if(!isGrounded){
	accTemporal		= accAir;
	fricTemporal	= fricAir;
} else {
	accTemporal		= accGround;
	fricTemporal	= fricGround;
}
	
//Stop jump if head touch celling
if(collisionUp){
	if(jumpSpd != 0) jumpSpd = 1;
}

#region Speed
	//Horizontal Speed
	if (movement != 0) spd = scr_approach(spd, maxSpd * movement, accTemporal);
	else spd = scr_approach(spd, maxSpd * movement, fricTemporal);

	//Vertical Speed
	if(!isGrounded){
		jumpSpd = scr_approach(jumpSpd, maxJumpSpd, gravityNorm);
	}
#endregion

#region Collisions
	scr_collisions(spd, jumpSpd);
#endregion