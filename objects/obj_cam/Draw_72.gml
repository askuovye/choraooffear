if (!instance_exists(obj_player)) exit;

draw_clear(global.fog_colour);

var _ztilt = lengthdir_y(1, tilt);
var _lookz = cam_z + _ztilt;
var _zmult = 1 - abs(_ztilt);
var _lookx = cam_x + lengthdir_x(_zmult, direction);
var _looky = cam_y + lengthdir_y(_zmult, direction);

view_mat = matrix_build_lookat(cam_x, cam_y, cam_z, _lookx, _looky, _lookz, 0, 0, -1);
camera_set_view_mat(cam, view_mat);