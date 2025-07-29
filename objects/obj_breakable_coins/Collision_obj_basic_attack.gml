if(!invisible){
	invisible = true;
	var coinArray = scr_sort_coins(wallet, minDropCoin * other.damage, maxDropCoin * other.damage);
	if(wallet.goingEmpty(lastDropCoin)){
		coinArray = array_concat(coinArray, scr_sort_coins(wallet, lastDropCoin, lastDropCoin));
		coinJumpSpd *= 1.25;
	}
	scr_dropping_coins(x,y, coinArray, coinSpd, coinJumpSpd);
	alarm[0] = recoverBehavior;
	image_blend = c_ltgray;
}
//Without coins to share
if(wallet.goingEmpty(0)){
	instance_destroy();
}