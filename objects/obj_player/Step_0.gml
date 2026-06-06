/// @description Insert description here
// You can write your code in this editor

var _mx = window_mouse_get_delta_x();
var _my = window_mouse_get_delta_y();

direction -= _mx * sens_x;
tilt += _my * sens_y;

tilt = clamp(tilt, -80, 80);

if (keyboard_check(vk_escape)) {
    game_end();
}


