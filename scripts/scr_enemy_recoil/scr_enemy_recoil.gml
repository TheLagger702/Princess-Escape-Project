#region Enemy recoil
	function scr_vertical_recoil(affectedObj){
	}
	
	function scr_recoil_damage(affectedObj, xdir, ydir, recoilmtp){
		var signSpd		= sign(affectedObj.spd);
		var signJumpSpd = sign(affectedObj.jumpSpd);
		
		//Si ataque es vertical
		if(ydir < 0) && (affectedObj.collisionUp) {
			affectedObj.jumpSpd = 0;
		}else if (ydir > 0) && (affectedObj.isGrounded) {
			affectedObj.jumpSpd = 0;
		} else {
			if(ydir == 0 && xdir != 0){
				affectedObj.jumpSpd = -affectedObj.maxJumpSpd * 0.75 * recoilmtp;
			}
			
			if(ydir > 0){
				affectedObj.jumpSpd     = affectedObj.maxJumpSpd * 0.75 * recoilmtp;
			} else if (ydir < 0) {
				affectedObj.jumpSpd     = -affectedObj.maxJumpSpd * 0.75 * recoilmtp;
			} 
		}
		
		//Si ataque es horizontal
		if(xdir > 0){
			if(signSpd < 0){
				affectedObj.movement = 1;
			}
			affectedObj.spd     = affectedObj.maxSpd * 1.5 * recoilmtp;
		} else if (xdir < 0) {
			if(signSpd > 0){
				affectedObj.movement= -1;
			}
			affectedObj.spd     = -affectedObj.maxSpd * 1.5 * recoilmtp;
		} 
	}
#endregion