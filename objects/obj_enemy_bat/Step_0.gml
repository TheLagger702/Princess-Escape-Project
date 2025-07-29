event_inherited();
var isAlmostGround = scr_is_ground(x	, y + groundLimit, jumpSpd);
if(restPosible && collisionUp){
		resting = true;
}

if(playerInRange && !invisible && !resting){	
	if(alarm[1] == -1)	alarm[1]   = restTime;
	
	//-----------------//
	movement   = playerDirection;
	if(!isGrounded){
		if(obj_player.y > y){
			airMovement = 1;
		} else {
			airMovement = -1;
		}
	}
	if(isAlmostGround || isGrounded){
		airMovement = -1;
	}
	
	
	//Simulating flying with jumping
	//if(jumpSpd == maxJumpSpd || isAlmostGround || isGrounded){
	//	jumpSpd = -flyingJump;
				
	//	if(obj_player.y >= y && flyingJump >= maxJumpSpd){
	//		flyingJump --;
	//	} else if (obj_player.y < y && flyingJump <= maxJumpSpd) {
	//		flyingJump ++;
	//	}
	//}
} 
else if(resting){ //Rest case
	jumpSpd = 0;
	movement = 0;
	if(alarm[1] == -1)	alarm[1]    = restTime;
	if(!restPosible)	resting		= false;
} else {
	movement = 0;
	airMovement = 0;
	jumpSpd = 0;
	//if(collisionUp){
	//	jumpSpd = 0;
	//}
}



