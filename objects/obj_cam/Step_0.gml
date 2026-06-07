if (!instance_exists(obj_player)) {
    exit;
}

var _mx = window_mouse_get_delta_x();
var _my = window_mouse_get_delta_y();

direction -= _mx * sens_x;
tilt += _my * sens_y;

tilt = clamp(tilt, -80, 80);
