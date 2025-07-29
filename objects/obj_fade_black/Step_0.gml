if (fading_in) {
    fade_alpha += fade_speed;
    if (fade_alpha >= 1) {
        fade_alpha = 1;
        fading_in = false;
    }
} else if (fading_out) {
    fade_alpha -= fade_speed;
    if (fade_alpha <= 0) {
        fade_alpha = 0;
        fading_out = false;
		instance_destroy();
    }
}