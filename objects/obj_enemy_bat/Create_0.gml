// Inherit the parent event
event_inherited();
hp = 2;

recoilMtp = 2.5;
maxSpd = 2;
maxJumpSpd = 2;

//Detecting player
visionRange		= sprite_width * 6;

//Coin Drops
smallCoins		= 3;
mediumCoins		= 0;
bigCoins		= 0;
wallet = new Wallet(smallCoins, mediumCoins, bigCoins);

//flying conditions
groundLimit = sprite_height * 1;

//Rest conditions
restTime	= 1800;
restPosible	= false;
resting		= false;


