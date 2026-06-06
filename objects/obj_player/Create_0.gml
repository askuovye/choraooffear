/// @description Insert description here
// You can write your code in this editor
cam = camera_create_view(0, 0, global.res_w, global.res_h);
view_enabled = true;
view_visible[0] = true;
view_camera[0] = cam;

proj_mat = matrix_build_projection_perspective_fov(80, -global.res_w / global.res_h, 3, 3000);
camera_set_proj_mat(cam, proj_mat);

view_mat = [];
z = 24;
direction = 0;
tilt = 0;

sens_y = 0.2;
sens_x = 0.2;

window_mouse_set_locked(true);
