if (!instance_exists(obj_player)) {
    exit;
}

draw_clear(global.fog_colour);

var _px = obj_player.x;
var _py = obj_player.y;
var _pz = obj_player.z;

var _ztilt = lengthdir_y(1, tilt);

var _lookz = _pz + _ztilt;
var _zmult = 1 - abs(_ztilt);
var _lookx = _px + lengthdir_x(_zmult, direction);
var _looky = _py + lengthdir_y(_zmult, direction);

view_mat = matrix_build_lookat(_px, _py, _pz, _lookx, _looky, _lookz, 0, 0, -1);
camera_set_view_mat(cam, view_mat);
