event_inherited();
var isAlmostAirRight = !place_meeting(x + sprite_width, y + sprite_height, obj_enviroment);
var isAlmostAirLeft  = !place_meeting(x - sprite_width, y + sprite_height, obj_enviroment);

if(
	(collisionLeft || collisionRight || isAlmostAirRight || isAlmostAirLeft) && 
	movement != 0 && changeMove && isGrounded
){
	changeMove = false;
	movement *= -1;
	alarm[1] = changeTime;
}

