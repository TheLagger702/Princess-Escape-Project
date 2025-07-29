x = obj_player.x;
var followY = obj_player.y;
var view_h = camera_get_view_height(view_camera[0]);
var top = y - view_h / 2 + border;
var bottom = y + view_h / 2 - border;

if (followY < top) {
    targetY = y - (top - followY);
} else if (followY > bottom) {
    targetY = y + (followY - bottom);
} else {
	targetY = y;
}
if(!cameraUp && !cameraDown && round(targetY) != round(oldY)){
	oldY = targetY;
}

if (global.focusTime == 1) {
    targetY = lerp(targetY, oldY - offsetCamera, 0.1);
	cameraUp = true;
} else if (global.focusTime == -1) {
    targetY = lerp(targetY, oldY + offsetCamera, 0.1);
	cameraDown = true;
} else {
	if(cameraUp || cameraDown){
		targetY = lerp(targetY, oldY, 0.3);
		if(round(targetY) == round(oldY)){
			cameraUp	= false;
			cameraDown	= false;
		}
	}
}
// Update camera y position
y = targetY;

//update camera position
camera_set_view_pos(view_camera[0], x - camera_get_view_width(view_camera[0])/2, y - view_h/2);