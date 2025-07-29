var drop = wallet.totalCoins();
var coinArray = scr_sort_coins(wallet, drop, drop);
scr_dropping_coins(x,y - sprite_yoffset, coinArray, maxSpd, maxJumpSpd * 1.25);