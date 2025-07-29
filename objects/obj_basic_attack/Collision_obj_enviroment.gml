if(!collision){
	collision = true;
	if(player != noone){
		scr_attack_recoil(player, other.mtpRecoil);
	}
}