/// @description Insert description here
// You can write your code in this editor

if (!instance_exists(obj_player)) {
    exit;
}

if (global.game_paused) {
    exit;
}

var _spd = point_distance(0, 0, obj_player.move_x, obj_player.move_y) / obj_player.move_speed;
var _sinewave = sin(current_time / 100);
var _offset_x = _sinewave * _spd * 10;


_sinewave = sin(current_time / 50);
var _offset_y = _sinewave * _spd * 10;

offset_x = lerp(offset_x, _offset_x, 0.2);
offset_y = lerp(offset_y, _offset_y, 0.2);


// movimento realista uhhhhh
var _shift_x = window_mouse_get_delta_x() * -2;
var _shift_y = window_mouse_get_delta_y() * -1;


shift_x = lerp(shift_x, _shift_x, 0.05);
shift_y = lerp(shift_y, _shift_y, 0.05);

offset_x += shift_x;
offset_y += shift_y;

if (_player != noone ){
    if (_player.hp <= 1) {
        return hud_low_rank();
    }
    if (_player.rank <= 0) {
        return hud_iddle_rank();
    }
    if (_player.rank >= 1) {
        return hud_medium_rank();
    }
    if (_player.rank >= 3) {
        return hud_high_rank();
    }
    if (_player.rank >= 4) {
        return hud_extreme_rank();
    }
}

