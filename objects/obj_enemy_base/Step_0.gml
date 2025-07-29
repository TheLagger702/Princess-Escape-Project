if(hp <= 0){
	instance_destroy();
}

//Boolean Collisions
collisionLeft	= place_meeting(x -1, y   , obj_wall);
collisionRight	= place_meeting(x +1, y   , obj_wall);
collisionUp     = place_meeting(x   , y -1, obj_wall);
isGrounded		= scr_is_ground(x	, y   , jumpSpd);

//Player Detection
if(instance_exists(obj_player)){
	var objPlayer = instance_nearest(x, y, obj_player);
	var dist = point_distance(x, y, objPlayer.x, objPlayer.y);
	var dir  = point_direction(x, y, objPlayer.x, objPlayer.y);
	playerInRange = (dist <= visionRange);
	if(dir > 90 && dir < 270){ playerDirection = -1}
	else if (dir == 90 || dir == 270){ playerDirection = 0}
	else { playerDirection = 1 }
}

//Define acceleration and friction from the enviroment
if(!isGrounded){
	accTemporal		= accAir;
	fricTemporal	= fricAir;
} else {
	accTemporal		= accGround;
	fricTemporal	= fricGround;
	if(jumpCount == 0) jumpCount = jumpExtra;
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
		if(airMovement != 0) jumpSpd = scr_approach(jumpSpd, maxJumpSpd * airMovement, gravityNorm);
		else jumpSpd = scr_approach(jumpSpd, maxJumpSpd, gravityNorm);
	}
#endregion

#region Collisions
	scr_collisions(spd, jumpSpd);
#endregion