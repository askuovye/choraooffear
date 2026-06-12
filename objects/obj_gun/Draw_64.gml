/// @description Insert description here
// You can write your code in this editor

gpu_push_state();
gpu_set_fog(false, 0, 0, 0);

var _scale = 4;
draw_sprite_ext(sprite_index, image_index, global.res_w - 300 + offset_x, global.res_h + offset_y, _scale, _scale, image_angle + offset_angle, image_blend, image_alpha);

gpu_pop_state();


