if(!invisible){
	invisible = true;
	hp -= 1;
	shake_time = 15;         // How many steps to shake
	shake_magnitude = 2;     // How strong the shake is (in pixels)
	alarm[1] = shake_time;
	alarm[0] = recoverBehavior;
	image_blend = c_ltgray;
}
//Without coins to share
//if(wallet.goingEmpty(0)){
//	instance_destroy();
//}