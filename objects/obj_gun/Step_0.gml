/// @description Insert description here
// You can write your code in this editor

if (!instance_exists(obj_player)) {
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


//CHUMBO GROSSO
if (mouse_check_button(mb_left) && shoot_time <= 0) {
    
    if (!instance_exists(obj_cam)) {
        exit;
    }

    var _cam = instance_find(obj_cam, 0);

    var _range = 1000;

    var _x1 = _cam.cam_x;
    var _y1 = _cam.cam_y;
    var _z1 = _cam.cam_z;

    var _x2 = _x1 + _cam.look_x * _range;
    var _y2 = _y1 + _cam.look_y * _range;
    var _z2 = _z1 + _cam.look_z * _range;

    shoot();
    shoot_time = shoot_interval;

    var _tr = instance_create_layer(0, 0, "Instances", obj_bullet);

    _tr.x1 = _x1;
    _tr.y1 = _y1;
    _tr.z1 = _z1;

    _tr.x2 = _x2;
    _tr.y2 = _y2;
    _tr.z2 = _z2;

    _tr.col = c_yellow;

    show_debug_message("SHOT START:");
    show_debug_message(string(_x1) + ", " + string(_y1) + ", " + string(_z1));

    show_debug_message("SHOT END:");
    show_debug_message(string(_x2) + ", " + string(_y2) + ", " + string(_z2));
}   
if (shoot_time > 0) {
        shoot_time--;
}
