if(!open){
	open = true;
	image_blend = c_ltgray;
	switch(type){
		case "coins":
			var dropCoins = drop.totalCoins();
			var coinArray = scr_sort_coins(drop, dropCoins, dropCoins);
			scr_dropping_coins(x,y - sprite_yoffset, coinArray, maxDropSpd, maxDropJumpSpd * 1.25);
		break;
	}
	
}