cam = camera_create_view(0, 0, global.res_w, global.res_h);

view_enabled = true;
view_visible[0] = true;
view_camera[0] = cam;

proj_mat = matrix_build_projection_perspective_fov(80, -global.res_w / global.res_h, 3, 3000);

camera_set_proj_mat(cam, proj_mat);

view_mat = matrix_build_identity();

direction = 0;
tilt = 0;

sens_y = 0.2;
sens_x = 0.2;

cam_x = 0;
cam_y = 0;
cam_z = 0;

look_x = 1;
look_y = 0;
look_z = 0;

look_at_x = 0;
look_at_y = 0;
look_at_z = 0;

window_mouse_set_locked(true);
// bobbing timer used by Step event
bob_timer = 0;
cam_bob_z = 0;
cam_bob_target_z = 0;
last_zspd = 0;
cam_jump_bob_z = 0;
cam_jump_bob_target_z = 0;

landing_impact = 0;
was_grounded = true;