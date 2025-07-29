if (alarm[1] != -1) {
    shake_offset_x = random_range(-shake_magnitude, shake_magnitude);
    shake_offset_y = random_range(-shake_magnitude, shake_magnitude);
} else {
    shake_offset_x = 0;
    shake_offset_y = 0;
}

if(hp <= 0){
	instance_destroy();
}