//Damage with danger enviroment elements
fallingTime = 0;
x = saveX;
y = saveY;
jumpSpd = 0;
spd		= 0;
if (instance_exists(obj_fade_black)) {	
	with (obj_fade_black) {
		fading_out = true;
		fading_in = false;
		fade_alpha = 1;
	}
}