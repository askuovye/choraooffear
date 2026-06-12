if (!instance_exists(obj_player)) {
    exit;
}

var _mx = window_mouse_get_delta_x();
var _my = window_mouse_get_delta_y();

direction -= _mx * sens_x;
tilt += _my * sens_y;

tilt = clamp(tilt, -80, 80);

cam_x = obj_player.x;
cam_y = obj_player.y;
cam_z = obj_player.z;

var _ztilt = lengthdir_y(1, tilt);

look_at_z = cam_z + _ztilt;

var _zmult = 1 - abs(_ztilt);

look_at_x = cam_x + lengthdir_x(_zmult, direction);
look_at_y = cam_y + lengthdir_y(_zmult, direction);

look_x = look_at_x - cam_x;
look_y = look_at_y - cam_y;
look_z = look_at_z - cam_z;

var _len = sqrt(
    look_x * look_x +
    look_y * look_y +
    look_z * look_z
);

if (_len != 0) {
    look_x /= _len;
    look_y /= _len;
    look_z /= _len;
}

var _spd = point_distance(0, 0, obj_player.move_x, obj_player.move_y) / obj_player.move_speed;
_spd = clamp(_spd, 0, 1);

var _moving = (_spd > 0.05);
var _grounded = obj_player.on_ground;

var _walk_wave = sin(current_time / 45);

if (_moving && _grounded) {
    cam_bob_target_z = _walk_wave * _spd * 0.02;
} else {
    cam_bob_target_z = 0;
}

cam_bob_z = lerp(cam_bob_z, cam_bob_target_z, 0.2);


var _zspd = obj_player.zspd;

if (!_grounded) {
    cam_jump_bob_target_z = clamp(-_zspd * 0.08, -1.2, 1.2);
} else {
    cam_jump_bob_target_z = 0;
}

cam_jump_bob_z = lerp(cam_jump_bob_z, cam_jump_bob_target_z, 0.12);


// guardar velocidade vertical anterior
var _prev_zspd = last_zspd;
last_zspd = obj_player.zspd;

// impacto ao aterrissar somente se caiu de verdade
if (_grounded && !was_grounded && _prev_zspd < -9) {
    landing_impact = -0.7;
}

was_grounded = _grounded;

landing_impact = lerp(landing_impact, 0, 0.15);

cam_z += cam_bob_z + cam_jump_bob_z + landing_impact;