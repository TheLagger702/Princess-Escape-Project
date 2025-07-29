/*
	Because the spider changes phisics when the string is active
	there is no event_inherance
*/
var dirPlayer, xPlayer=0;

if(hp <= 0){
	instance_destroy();
}

//Cutted rope
if(!hanging){
	objString = noone;
}

//Boolean Collisions
collisionLeft	= place_meeting(x -1, y   , obj_wall);
collisionRight	= place_meeting(x +1, y   , obj_wall);
collisionUp     = place_meeting(x   , y -1, obj_wall);
isGrounded		= scr_is_ground(x	, y   , jumpSpd);

//Player Detection
if(instance_exists(obj_player)){
	var objPlayer	= instance_nearest(x, y, obj_player);
	var dist		= 0;
	dirPlayer		= point_direction(x, y, objPlayer.x, objPlayer.y);
	xPlayer			= objPlayer.x;
	if(objString != noone)	
		dist = point_distance(objString.anchorX, objString.anchorY, objPlayer.x, objPlayer.y);
	else					dist = point_distance(x, y, objPlayer.x, objPlayer.y);
	
	playerInRange = (dist <= visionRange);
	if(dirPlayer > 90 && dirPlayer < 270){ playerDirection = -1}
	else if (dirPlayer == 90 || dirPlayer == 270){ playerDirection = 0}
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
	if(hanging) {
		//Hanging from a string Speed
		var dist  = point_distance(x, y, objString.x, objString.y);
		var dir   = point_direction(x, y, objString.x, objString.y);
		var signDistX	= sign(lengthdir_x(dist, dir));	
		var signDistY	= sign(lengthdir_y(dist, dir));	
		//=======================//
		
		fricTemporal    = fricString; 
		if(movement != sign(signDistX))	accTemporal	= accTemporal * 1.5;
		else accTemporal = accString;
		
		movement = signDistX;
		//=======================//
		
		//Vertical Speed
		if(dist > stringLength){
			if(changeMove){
				jumpSpd = maxJumpSpd * signDistY;
				changeMove = false;
				alarm[10] = recoverBehavior;
			}
		}
		else if (dist > stringLength -5 && dist <= stringLength){
			jumpSpd *= fricString;
		}
		else {
			if(airMovement != 0) jumpSpd = scr_approach(jumpSpd, maxJumpSpd * airMovement, gravityNorm);
			else jumpSpd = scr_approach(jumpSpd, maxJumpSpd, gravityNorm);
		}
	} 
	else {
		//Vertical Speed
		if(!isGrounded){
			if(airMovement != 0) jumpSpd = scr_approach(jumpSpd, maxJumpSpd * airMovement, gravityNorm);
			else jumpSpd = scr_approach(jumpSpd, maxJumpSpd, gravityNorm);
		}
	}
	
	//Horizontal Speed
	if (movement != 0) spd = scr_approach(spd, maxSpd * movement, accTemporal);
	else spd = scr_approach(spd, maxSpd * movement, fricTemporal);
#endregion

#region Collisions
	scr_collisions(spd, jumpSpd);
#endregion

#region State Machine
	//State Machine 
	state = stateMachine.getState();
	show_debug_message(state);
	if(state != undefined){
		switch(state){
			case enemy_spider1_state.hide:
				stateMachine.setState(enemy_spider1_state.hide);
				stateMachine.update(
					{}, 
					[
						{
							_conditions:{},
							_next_state: enemy_spider1_state.idle,
							_exit_params: undefined,
							_enter_params: undefined 
						},
						{
							_conditions:{},
							_next_state: enemy_spider1_state.walk,
							_exit_params: undefined,
							_enter_params: { _x: xPlayer }
						}
					]
				);
			break;
			case enemy_spider1_state.idle:
				stateMachine.setState(enemy_spider1_state.idle);
				stateMachine.update(
					{}, 
					[
						{ 
							_conditions:{},
							_next_state: enemy_spider1_state.charge,
						    _exit_params: undefined,
							_enter_params: undefined 
						},
						{ 
							_conditions:{},
							_next_state: enemy_spider1_state.walk,
							_exit_params: undefined,
							_enter_params: { _x: xPlayer }
						},
						{ 
							_conditions:{},
							_next_state: enemy_spider1_state.hide,
							_exit_params: undefined,
							_enter_params: undefined 
						}
					]
				);
			break;
			case enemy_spider1_state.walk:
				stateMachine.setState(enemy_spider1_state.walk);
				stateMachine.update(
					{}, 
					[
						{ 
							_conditions:{},
							_next_state: enemy_spider1_state.hide,
							_exit_params: undefined,
							_enter_params: undefined 
						},
					]
				);
			break;
			case enemy_spider1_state.charge:
				stateMachine.setState(enemy_spider1_state.charge);
				stateMachine.update(
					{}, 
					[
						{ 
							_conditions:{},
							_next_state: enemy_spider1_state.attack,
							_exit_params: {
								_dir:dirPlayer
							},
							_enter_params: undefined 
						},
						{ 
							_conditions:{},
							_next_state: enemy_spider1_state.walk,
							_exit_params: undefined,
							_enter_params: { _x: xPlayer }
						}
					]
				);
			break;
			case enemy_spider1_state.attack:
				stateMachine.setState(enemy_spider1_state.attack);
				stateMachine.update(
					{}, 
					[
						{ 
							_conditions:{},
							_next_state: enemy_spider1_state.idle,
							_exit_params: undefined ,
							_enter_params: undefined 
						},
						{ 
							_conditions:{},
							_next_state: enemy_spider1_state.walk,
							_exit_params: undefined,
							_enter_params: { _x: xPlayer }
						}
					]
				);
			break;
		}	
	}
#endregion

