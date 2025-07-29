// Inherit the parent event
event_inherited();
stateMachine	= new StateMachine();
hp				= 3;

//Movement
changeMove = true;
hide	   = false;

//Hurt
recoverBehavior = 15;
recoilMtp		= 1.5;
maxSpd			= 4;
maxJumpSpd		= 4;
accString		= 0.4   * moveMtp;
fricString		= 0.6   * moveMtp;

//Detecting player
visionRange		= sprite_width * 10;

//Attack
chargingTime	= 60;
chargeDone		= false;
atkCooldown		= 300;
atkDone			= false;
atkDuration		= 30;
atkEnd			= false;

atkSpd			= 2;
lastDirAtk		= 0;

//Coin Drops
smallCoins		= 5;
mediumCoins		= 0;
bigCoins		= 0;
wallet = new Wallet(smallCoins, mediumCoins, bigCoins);

//Find the first wall up of the spider
#region Spider String up
	objString = noone;
	hanging   = false;
	if(instance_exists(obj_wall)){
		var line = collision_line(x, y, x, y - stringLength, obj_wall, false, false);
		if (line != noone) {
			objString = instance_create_layer(x, y, "Instances", obj_string);
			objString.anchorX = x;
			objString.anchorY = line.y + line.sprite_height - 10;
			objString.stringLength = stringLength;
			objString.spider = self;
			objString.wall = line;
			objString.x = objString.anchorX;
			objString.y = objString.anchorY;
			objString.gravityNorm = gravityNorm;
		
			hanging = true;
		}
	}
#endregion

#region Transitions
	#region Hide Transition
		var hideTransitions = ds_map_create();
		ds_map_add(
			hideTransitions, 
			enemy_spider1_state.idle,
			function(_conditions){
				if(_conditions == undefined) return false;
				return self.playerInRange;
			}
		);
		ds_map_add(
			hideTransitions, 
			enemy_spider1_state.walk,
			function(_conditions){
				return !self.hanging;
			}
		);
	#endregion
	#region Idle Transition
		var idleTransitions = ds_map_create();
		ds_map_add(
			idleTransitions, 
			enemy_spider1_state.charge,
			function(_conditions){
				return self.atkDone && self.playerInRange;
			}
		);
		ds_map_add(
			idleTransitions, 
			enemy_spider1_state.walk,
			function(_conditions){
				return !self.hanging;
			}
		);
		ds_map_add(
			idleTransitions, 
			enemy_spider1_state.hide,
			function(_conditions){
				return !self.playerInRange;
			}
		);
	#endregion
	#region Walk Transition
		var walkTransitions = ds_map_create();
		ds_map_add(
			walkTransitions, 
			enemy_spider1_state.hide,
			function(_conditions){
				return self.hanging;
			}
		);
	#region Charge Transition
		var chargeTransitions = ds_map_create();
		ds_map_add(
			chargeTransitions, 
			enemy_spider1_state.attack,
			function(_conditions){
				return self.chargeDone;
			}
		);
		ds_map_add(
			chargeTransitions, 
			enemy_spider1_state.walk,
			function(_conditions){
				return !self.hanging;
			}
		);
	#endregion
	#region Attack Transition
		var atkTransitions = ds_map_create();
		ds_map_add(
			atkTransitions, 
			enemy_spider1_state.idle,
			function(_conditions){
				return self.atkEnd;
			}
		);
		ds_map_add(
			atkTransitions, 
			enemy_spider1_state.walk,
			function(_conditions){
				return !self.hanging;
			}
		);
	#endregion
#endregion

#region States
	#region Hide state
	stateMachine.addState(new EnemyState(
		enemy_spider1_state.hide,
		function (){},
		function (_parameters){
			if(hanging){
				if(self.collisionUp){
					self.y				= room_height + 64;
					self.objString.y	= room_height + 64;
					self.hide			= true;
				} else {
					if(self.hide){
						self.spd		= 0;
						self.jumpSpd	= 0;
					} else {
						self.jumpSpd = -self.maxJumpSpd;
					}
					
				}
			}
		},
		function (_exit_params){
			self.hide = false;
		},
		hideTransitions
	));
	#endregion
	#region Idle state
	stateMachine.addState(new EnemyState(
		enemy_spider1_state.idle,
		function (){
			if(self.hanging && self.objString.y != self.objString.anchorY){
				self.y				= self.objString.anchorY + 10;
				self.objString.y	= self.objString.anchorY;
			}
		},
		function (){
			if(self.alarm[7] == -1)	self.alarm[7] = self.atkCooldown;
		},
		function (){ 
			self.atkDone = false;	
		},
		idleTransitions
	));
	#endregion
	#region Walk state
	stateMachine.addState(new EnemyState(
		enemy_spider1_state.walk,
		function (_enter_params){ //HACERLO MOVER EN DIRECCION DE DONDE EL JUGADOR ESTA
			var signX = sign(_enter_params._x - self.x);
			self.movement = signX;
		},
		function (){
			var isAlmostAirRight = !place_meeting(
										self.x + self.sprite_width, 
										self.y + self.sprite_height, 
										obj_enviroment
									);
			var isAlmostAirLeft  = !place_meeting(
										self.x - self.sprite_width, 
										self.y + self.sprite_height, 
										obj_enviroment
									);
			if(
				(self.collisionLeft || self.collisionRight || isAlmostAirRight || isAlmostAirLeft)
				 && self.movement != 0 && self.changeMove && self.isGrounded
			){
				self.changeMove = false;
				self.movement *= -1;
				alarm[10]	   = recoverBehavior;
			}
		
		},
		function (){
			self.movement = 0;
		},
		walkTransitions
	));
	#endregion
	#region Charge state
	stateMachine.addState(new EnemyState(
		enemy_spider1_state.charge,
		function (){ },
		function (){ 
			image_blend  = c_ltgray;	
			if(self.alarm[8] == -1) self.alarm[8] = self.chargingTime;
		},
		function (_exit_params){
			if(_exit_params != undefined){
				self.lastDirAtk	 = _exit_params._dir;
			}
			self.chargeDone = false;	
		},
		chargeTransitions
	));
	#endregion
	#region Attack state
	stateMachine.addState(new EnemyState(
		enemy_spider1_state.attack,
		function (){ self.chargeDone = false; image_blend  = c_white; },
		function (_parameters){
			if(self.alarm[9] == -1) {
				scr_enemy_long_attack(
					self.damage,
					1,
					self.atkSpd,
					1,
					1,
					self.lastDirAtk,
					obj_enemy_shot
				);	
				self.alarm[9] = self.atkDuration;
			}
		},
		function (){ 	
			self.atkEnd = false;	
		},
		atkTransitions
	));
	#endregion
#endregion

if(hanging) stateMachine.setInitialState(enemy_spider1_state.hide);
else		stateMachine.setInitialState(enemy_spider1_state.walk);

state = undefined;