if(!invinsible){
	scr_recoil_attack_enemies(self, other);
	invinsible = true;
	attackAble = false;
	alarm[enumPlayerAlarms.endInvisibility] = invinsibleTime;
	image_blend = c_gray; //cambiar luego
}
