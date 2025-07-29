function scr_enemy_long_attack(atkDamage, atkRange, atkSpeed, xscale, yscale, dir, atkObj){
	var attack = instance_create_layer(
	    x + lengthdir_x(atkRange, dir),
	    y + lengthdir_y(atkRange, dir),
		"Attacks",
		atkObj
	);
	
	attack.damageReal  = atkDamage;
	attack.spd	       = atkSpeed;
	attack.dir		   = dir;
	attack.image_index  = 0;
	attack.image_xscale = xscale;
	attack.image_yscale = yscale;
}