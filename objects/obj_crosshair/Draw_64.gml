/// @description Insert description here
// You can write your code in this editor


gpu_push_state();
gpu_set_fog(false, 0, 0, 0);

var _scale = 0.5;

draw_sprite_ext(sprite_index, 0, global.res_w / 2, global.res_h / 2, _scale, _scale, 0, c_white, 1);

gpu_pop_state();



