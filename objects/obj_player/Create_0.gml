hp			= 3;
wallet		= 0;
jumpCount = 0;

//Movement
moveMtp		= 1;
viewDir		= 0;
lastDir		= 0;
spd			= 0;
jumpSpd		= 0;
maxSpd		= 6		* moveMtp;
maxJumpSpd	= 8.5 	* moveMtp;
jumpHeight  = 8		* moveMtp; //NO SE USA
gravityNorm = 0.5	* moveMtp;
accGround   = 0.75	* moveMtp;
accAir		= 0.75  * moveMtp;
fricGround  = 1.9	* moveMtp;
fricAir		= 0.1   * moveMtp;
movement	= 0;

accTemporal     = 0;
fricTemporal    = 0;
collisionLeft   = false;
collisionRight  = false;
collisionUp		= false;
isGrounded		= true;

//Falling recoil
recoilFallingTime = 15;
fallingTime		  = 0;
moveAble		  = true;

//Save Spot Return
saveX			= x;
saveY			= y; 
nearestDamage	= noone;
saveRange		= 32 * 6;

//Enemies
atkRange		 = sprite_width;
atkCooldown		 = 25;
atkTime		     = 60;
atkDamage		 = 1;
comboWindow		 = 120;
attackAble		 = true;
invinsibleTime	 = 30;
invinsible		 = false;

//Camera press time
focusTime = 0;

//Aditional mechanics
jumpExtra		= 0;
