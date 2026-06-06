/// @description Insert description here
// You can write your code in this editor

draw_clear(global.fog_colour);

var _ztilt = lengthdir_y(1, tilt);

var _lookz = z + _ztilt;
var _zmult = 1 - abs(_ztilt);
var _lookx = x + lengthdir_x(_zmult, direction) * _zmult;
var _looky = y + lengthdir_y(_zmult, direction) * _zmult;

view_mat = matrix_build_lookat(x, y, z, _lookx, _looky, _lookz, 0, 0, -1);
camera_set_view_mat(cam, view_mat);



