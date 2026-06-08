if (!instance_exists(obj_cam)) {
    exit;
}

var _direction = obj_cam.direction;

// movimento sexo
var _hor = real(keyboard_check(ord("D"))) - real(keyboard_check(ord("A")));
var _ver = - real(keyboard_check(ord("S"))) + real(keyboard_check(ord("W")));

zspd += grav;

if (keyboard_check(vk_shift)) {
    _hor *= 2;
    _ver *= 2;
}

var _foward_dir = _direction;
var _side_dir = _direction - 90;

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

move_player_3d(id, move_x, move_y);

//pulo do gato

zspd += grav;

if (keyboard_check_pressed(vk_space) && on_ground) {
    zspd = jump_speed * 1.5;
    on_ground = false;
}

if (keyboard_check_released(vk_space) && zspd > 0) {
    zspd *= 0.5;
}

var _prev_foot_z = z - camera_height;

z += zspd;

var _foot_z = z - camera_height;

var _ground = get_3d_ground_z(id, x, y, _prev_foot_z, _foot_z);

if (_foot_z <= _ground) {
    _foot_z = _ground;
    z = _foot_z + camera_height;

    zspd = 0;
    on_ground = true;
} else {
    on_ground = false;
}

move_player_3d(id, move_x, move_y);
// Sair do jogasso
if (keyboard_check(vk_escape)) {
    game_end();
}
