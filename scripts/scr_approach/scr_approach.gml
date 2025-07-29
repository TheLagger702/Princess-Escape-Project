function scr_approach(a0, a1, a2){
	if (a0 < a1)
		return min (a0 + a2, a1);
	else
		return max (a0 - a2, a1);
}