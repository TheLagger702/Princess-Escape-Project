function scr_dropping_coins(px, py, coins, maxSpd, maxJumpSpd){
	var lenghtCoins = array_length(coins);
	
	for(var i = 0; i < lenghtCoins; i += 1){
		var coin		= coins[i];
		var spd			= choose(irandom_range(-maxSpd, -1), irandom_range(1, maxSpd));
		var jumpSpd		= random_range(0.1, maxJumpSpd);
		var coinObj		= instance_create_layer(px, py, "Collectable", coin);
		coinObj.spd			= spd;
		coinObj.jumpSpd		= -jumpSpd;
	}
	
}