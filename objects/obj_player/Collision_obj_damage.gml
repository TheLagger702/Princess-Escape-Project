scr_recoil_damaging_enviroment(self);
//Fade to black screen
if (!instance_exists(obj_fade_black)) {
    instance_create_layer(0, 0, "GUI", obj_fade_black);
	
	with (obj_fade_black) {
	    fading_in = true;
	    fading_out = false;
	    fade_alpha = 0;
	}
	//Invulnerability frames
	invinsible = true;
	attackAble = false;
	alarm[enumPlayerAlarms.endInvisibility] = invinsibleTime;
	alarm[enumPlayerAlarms.damageEnviroment] = 30;
}