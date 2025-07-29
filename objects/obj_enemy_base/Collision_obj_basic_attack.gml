if(!invisible){
	hp -= other.damage;
	
	invisible = true;
	lastMovement = movement;
	scr_recoil_damage(self, other.xdir, other.ydir, recoilMtp);
	alarm[0] = recoverBehavior;
}
