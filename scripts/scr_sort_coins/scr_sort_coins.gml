function Wallet(_small = 0, _medium = 0, _big = 0) constructor{
	small = _small;
	medium = _medium;
	big = _big;
	
	static goingEmpty = function (dropCoins){
		var totalCoins = small + medium + big;
		return totalCoins <= dropCoins;
	}
	
	static totalCoins = function(){
		return small + medium + big;
	}
}

function scr_sort_coins(coins, minDropSize , maxDropSize){
	var coinArray = [];
	var totalCoins = coins.small + coins.medium + coins.big;
	var arrLength = irandom_range(minDropSize, maxDropSize);
	for(var i = 0; i < arrLength; i += 1){
		var randomValue = irandom_range(1, totalCoins);
		if(randomValue <= coins.small && coins.small > 0){
			coinArray[i] = obj_small_coin;
			coins.small--;
			totalCoins --;
		} else if ((randomValue <= coins.small + coins.medium) && coins.medium > 0){
			coinArray[i] = obj_medium_coin;
			coins.medium--;
			totalCoins --;
		} else if (coins.big > 0) {
			coinArray[i] = obj_big_coin;
			coins.big--;
			totalCoins --;
		}
	}
	return coinArray
}