/// @description Insert description here
// You can write your code in this editor

var _mx = window_mouse_get_delta_x();
var _my = window_mouse_get_delta_y();

direction -= _mx * sens_x;
tilt += _my * sens_y;

tilt = clamp(tilt, -80, 80);

// movimento sexo
var _hor = real(keyboard_check(ord("D"))) - real(keyboard_check(ord("A")));
var _ver = - real(keyboard_check(ord("S"))) + real(keyboard_check(ord("W")));

if (keyboard_check(vk_shift)) {
    _hor *= 2;
    _ver *= 2;
}

var _foward_dir = direction;
var _side_dir = direction-90;

var _move_x = lengthdir_x(_ver * move_speed, _foward_dir) + lengthdir_x(_hor * move_speed, _side_dir);
var _move_y = lengthdir_y(_ver * move_speed, _foward_dir) + lengthdir_y(_hor * move_speed, _side_dir);

if (abs(_move_x) < abs(move_x)) {
    move_x *= 0.9;
} else {
    move_x = _move_x;
}

if (abs(_move_y) < abs(move_y)) {
    move_y *= 0.9;
} else {
    move_y = _move_y;
}

move_and_collide(move_x, move_y, [obj_wall]);

// Chumbo grosso
if (mouse_check_button(mb_left) && shoot_time <= 0) {
    gun.shoot();
    shoot_time = shoot_interval;

    instance_create_depth(x, y, 0, obj_bullet, {
        speed: 20,
        direction: direction,
    })
}
if (shoot_time > 0) {
    shoot_time--;
}
// Sair do jogasso
if (keyboard_check(vk_escape)) {
    game_end();
}


