gpu_push_state();
gpu_set_fog(false, 0, 0, 0);

var _scale = 7;

var _draw_x = global.res_w - 1000 + offset_x + shift_x;
var _draw_y = global.res_h + offset_y + shift_y;

draw_sprite_ext(
    sprite_index,
    image_index,
    _draw_x,
    _draw_y,
    _scale,
    _scale,
    image_angle + offset_angle,
    image_blend,
    image_alpha
);



draw_set_font(fnt_arial);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);


if (_player != noone && _gun != noone) {
    draw_text(_draw_x + 75, _draw_y - 120, "vida: " + string(_player.hp));
    draw_text(_draw_x + 70, _draw_y - 90, "ammo: " + string(_gun.ammo_in_mag));
}



gpu_pop_state();