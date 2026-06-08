if (!instance_exists(obj_player)) {
    exit;
}

var _mx = window_mouse_get_delta_x();
var _my = window_mouse_get_delta_y();

direction -= _mx * sens_x;
tilt += _my * sens_y;

tilt = clamp(tilt, -80, 80);

// posição da câmera
cam_x = obj_player.x;
cam_y = obj_player.y;
cam_z = obj_player.z;

// ponto para onde a câmera olha
var _ztilt = lengthdir_y(1, tilt);

look_at_z = cam_z + _ztilt;

var _zmult = 1 - abs(_ztilt);

look_at_x = cam_x + lengthdir_x(_zmult, direction);
look_at_y = cam_y + lengthdir_y(_zmult, direction);

// vetor de direção da câmera
look_x = look_at_x - cam_x;
look_y = look_at_y - cam_y;
look_z = look_at_z - cam_z;

// normalizar
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

// mais movimento sexy ahhhh q delicia vey
