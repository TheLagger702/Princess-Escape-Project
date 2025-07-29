cam_width	= 683;
cam_height	= 384;
border   	= 120;
targetY		= obj_player.y;
oldY		= targetY;
camera = camera_create_view(obj_player.x, obj_player.y, cam_width, cam_height, 0, noone, -1, -1, -1, -1);
view_camera[0] = camera;

//Move camera
global.focusTime = 0;
cameraUp = false;
cameraDown = false;
offsetCamera = 50;