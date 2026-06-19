/// Draw GUI Event - obj_crosshair

gpu_push_state();

gpu_set_fog(false, 0, 0, 0);
gpu_set_ztestenable(false);
gpu_set_alphatestenable(false);

var _scale = 7;

var _cx = display_get_gui_width() * 0.5;
var _cy = display_get_gui_height() * 0.5;

draw_sprite_ext(
    spr_crosshair,
    0,
    _cx,
    _cy,
    _scale,
    _scale,
    0,
    c_white,
    1
);

gpu_pop_state();