if (!instance_exists(obj_player)) {
    exit;
}

draw_clear(global.fog_colour);

view_mat = matrix_build_lookat(cam_x, cam_y, cam_z, look_at_x, look_at_y, look_at_z, 0, 0, -1);

camera_set_view_mat(cam, view_mat);