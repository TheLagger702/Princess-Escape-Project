function scr_attack(atkDamage, atkRange, xscale, yscale, dir, atkObj){
	var attack = instance_create_layer(
	    x + lengthdir_x(atkRange, dir),
	    y + lengthdir_y(atkRange, dir),
		"Attacks",
		atkObj
	);
	attack.damage		= atkDamage;
	attack.player		= obj_player;
	switch(dir){
		case 0: attack.xdir = obj_player.sprite_width;
		break;
		case 90: attack.ydir = -obj_player.sprite_width;
		break;
		case 180: attack.xdir = -obj_player.sprite_width;
		break;
		case 270: attack.ydir = obj_player.sprite_width;
		break;
	}
	//ataque.sprite_index=sprDamage;
	attack.image_index  = 0;
	attack.image_xscale = xscale;
	attack.image_yscale = yscale;
}