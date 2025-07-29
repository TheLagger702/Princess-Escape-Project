if(cutted){
	instance_destroy();
}
	
if(spider != noone){
	dist = point_distance(x, y, spider.x, spider.y);
	dir  = point_direction(x, y, spider.x, spider.y);

	image_yscale = dist / initialHeight;
	if(dist >= stringLength + 64){
		cutted = true;
	}
}
