function scr_string_path(objSpider, anchorX, anchorY, cPoint, zigzag){
	var myPath= path_add();
	var _cPointX = objSpider.x / cPoint
	var _cPointY = (anchorY -y) / cPoint
	var _i = 1;
	var _o = 1;
	path_add_point(myPath, objSpider.x ,objSpider.y, 10);
	repeat(cPoint - 2){
		path_add_point(myPath,objSpider.x+(_cPointX *_i),objSpider.y+(_cPointY *_i) + zigzag* _o, 10);
		_i++;
		_o*=-1;
	}
	path_add_point(myPath, anchorX ,anchorY, 10);
	path_set_closed(myPath,false);
	path_set_kind(myPath, 0);
	return myPath;
}