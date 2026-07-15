/// @description Insert description here
// You can write your code in this editor

if (!dialog_active) {
    exit;
}

if (!instance_exists(obj_cam) || !instance_exists(obj_player)) {
    exit;
}

gpu_push_state();
gpu_set_fog(false, 0, 0, 0);

var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

var _box_x = _gui_w / 2;
var _box_y = _gui_h - 120;

draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (dialog_active) {
    draw_text(_box_x, _box_y, text);
}

gpu_pop_state();