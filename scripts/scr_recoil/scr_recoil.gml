#region Player recoil
	function scr_recoil_damaging_enviroment(affectedObj){
		affectedObj.jumpSpd = -affectedObj.maxJumpSpd * 0.75;
		affectedObj.spd     = 0;
	}

	function scr_recoil_enemies(affectedObj){
		var signSpd		= sign(affectedObj.spd);
		var signJumpSpd = sign(affectedObj.jumpSpd);
	
		if (signJumpSpd >= 0){
			affectedObj.jumpSpd = -affectedObj.maxJumpSpd * 0.75;
		} else {
			affectedObj.jumpSpd = affectedObj.maxJumpSpd * 0.75;
		}
		if(signSpd > 0){
			affectedObj.spd     = -affectedObj.maxSpd * 0.75;
		} else if (signSpd < 0) {
			affectedObj.spd     = affectedObj.maxSpd * 0.75;
		}
	}
	
	function scr_recoil_attack_enemies(affectedObj, attackObj){
		var signSpd		= sign(attackObj.x- affectedObj.x);
		var signJumpSpd = sign(affectedObj.jumpSpd);
	
		if (signJumpSpd >= 0){
			affectedObj.jumpSpd = -affectedObj.maxJumpSpd * 0.75;
		} else {
			affectedObj.jumpSpd = affectedObj.maxJumpSpd * 0.75;
		}
		if(signSpd > 0){
			affectedObj.spd     = -affectedObj.maxSpd * 0.75;
		} else if (signSpd < 0) {
			affectedObj.spd     = affectedObj.maxSpd * 0.75;
		}
	}

	function scr_attack_recoil(affectedObj, mtp){
		if(affectedObj.viewDir == 0){
			affectedObj.spd     = -affectedObj.maxSpd * 1.25 * mtp;
		} else if (affectedObj.viewDir == 180) {
			affectedObj.spd     = affectedObj.maxSpd * 1.25 * mtp;
		} else if (affectedObj.viewDir == 90){
			affectedObj.jumpSpd = affectedObj.maxJumpSpd * 0.75 * mtp;
		} else {
			affectedObj.jumpSpd = -affectedObj.maxJumpSpd * 0.75 * mtp;
		}
	}
#endregion