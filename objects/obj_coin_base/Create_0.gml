value = 1;
moveMtp = 1;

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
jumpCount = 0;
jumpExtra = 0;

accTemporal     = 0;
fricTemporal    = 0;
collisionLeft   = false;
collisionRight  = false;
collisionUp		= false;
isGrounded		= true;