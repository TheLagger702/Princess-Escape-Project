hp		= 3;
damage	= 1;
moveMtp = 1;

//Hurt
invisible = false;
recoilMtp = 1;
recoverBehavior = 15;
lastMovement	= 0;

wallet = new Wallet(0, 0, 0);

//Movement

spd			= 0;
jumpSpd		= 0;
maxSpd		= 2		* moveMtp;
maxJumpSpd	= 8.5 	* moveMtp;
gravityNorm = 0.5	* moveMtp;
accGround   = 0.75	* moveMtp;
accAir		= 0.75  * moveMtp;
fricGround  = 1.9	* moveMtp;
fricAir		= 0.1   * moveMtp;
movement	= 0;
airMovement = 0;
jumpCount = 0;
jumpExtra = 0;

accTemporal     = 0;
fricTemporal    = 0;
collisionLeft   = false;
collisionRight  = false;
collisionUp		= false;
isGrounded		= true;

//Detecting player
playerInRange	= false;
playerDirection = 0;
visionRange		= sprite_width * 8;

//SpawnPoint Return
spawnX			= x;
spawnX			= y; 
