var keyLeft, keyRight, keyDown, keyUp, keyJump, keyJumpRelease, keyAttack;

//keys
keyLeft  = keyboard_check(ord("A"));
keyRight = keyboard_check(ord("D"));
keyUp	 = keyboard_check(ord("W"));
keyDown  = keyboard_check(ord("S"));

keyAttack = keyboard_check_pressed(vk_shift); 

keyJump			= keyboard_check_pressed(vk_space);
keyJumpRelease  = keyboard_check_released(vk_space);

//Boolean Collisions
collisionLeft	= place_meeting(x -1, y   , obj_wall);
collisionRight	= place_meeting(x +1, y   , obj_wall);
collisionUp     = place_meeting(x   , y -1, obj_wall);
isGrounded		= scr_is_ground(x	, y   , jumpSpd);

#region Mechanics
	if(moveAble){
		movement =  keyRight -keyLeft;
		
		//Move Camera
		if(keyUp && !keyDown){ if(focusTime < 0) focusTime = 0; focusTime ++; }
		if(keyDown && !keyUp){ if(focusTime > 0) focusTime = 0; focusTime --; }
	
		//Jump
		if(keyJump){
			focusTime = 0;
			if(isGrounded){
				jumpSpd = -maxJumpSpd;
			} else if (!isGrounded && jumpCount > 0){ //Extra Jump
				jumpSpd = -maxJumpSpd;
				jumpCount--;
			}
		}
	
		//Jump Release
		if(keyJumpRelease){
			if(jumpSpd != 0) jumpSpd *= gravityNorm;
		}
	
		//Go down One sided Platform
		if(keyDown){
			if(place_meeting(x , y +1, obj_onesided) && !place_meeting(x , y +1, obj_wall)) y++
		}
	
		//Direction of view
		if(keyUp){viewDir = 90;}
		else if(keyDown && !isGrounded){viewDir = 270;}
		else if(keyRight && !keyLeft){viewDir = 0; lastDir = 0;}
		else if(keyLeft && !keyRight){viewDir = 180; lastDir = 180;}
		else {viewDir = lastDir;}
	
		//Attack
		if(keyAttack && attackAble){
			focusTime = 0;
			attackAble = false;
			alarm[enumPlayerAlarms.attackAgain]   = atkCooldown;
			scr_attack(atkDamage, atkRange, 1, 1, viewDir, obj_basic_attack);
		}
	}
#endregion

#region Camera
	if(movement != 0 || (!keyUp && !keyDown)) { focusTime = 0; global.focusTime = 0; }
	else {
		if(focusTime >= 40){
			global.focusTime = 1;
		} else {
			if(focusTime <= -40){
				global.focusTime = -1;
			} else {
				global.focusTime = 0;
			}
		}
	}
#endregion

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
		jumpSpd = scr_approach(jumpSpd, maxJumpSpd, gravityNorm);
		if(jumpSpd > 0) fallingTime++; //faling time
		else if (jumpSpd < 0) fallingTime--;
	} else {
		//if(fallingTime != 0) show_debug_message(fallingTime);
		if(fallingTime > recoilFallingTime){
			movement = 0;
			invinsible = true;
			moveAble = false;
			alarm[enumPlayerAlarms.moveAgain] = invinsibleTime + (fallingTime * 0.75);
			image_blend = c_gray; //cambiar luego
		}
		fallingTime = 0;
	}
#endregion

#region Collisions
	scr_collisions(spd, jumpSpd);
	
	if (instance_exists(obj_damage)){
		var objDamage = instance_nearest(x, y, obj_damage);
		if(nearestDamage != objDamage){
			var dist = point_distance(x, y, objDamage.x, objDamage.y);
			var outbound = ((x + sprite_xoffset + 16 < objDamage.x - objDamage.sprite_xoffset) || 
						   (x - sprite_xoffset -16 > objDamage.x + objDamage.sprite_xoffset)) ;
			var touchingEnemy = place_meeting(x , y ,obj_enemy_base);
			var touchingDamage = place_meeting(x , y + 16 ,objDamage);
			var breakableGround = place_meeting(x, y + 16, obj_breakingStepWall)
			
			if( 
				dist <= saveRange && isGrounded && outbound && 
				!touchingEnemy && !touchingDamage && !breakableGround
			){
				nearestDamage = objDamage;
				saveX		= x;
				saveY		= y; 
			}
		}
	}
#endregion