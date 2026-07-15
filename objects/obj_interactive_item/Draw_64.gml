/// @description Insert description here
// You can write your code in this editor
gpu_push_state();
gpu_set_fog(false, 0, 0, 0);

var _cast_vbm = variable_instance_exists(id, "collision_vbm") ? collision_vbm : vbm;

var _hit_pos = [0, 0, 0];
var _hit_nrm = [0, 0, 0];

var g_width = display_get_gui_width();
var g_height = display_get_gui_height();

if (!variable_instance_exists(id, "show_item")) show_item = false;
if (!variable_instance_exists(id, "item_collected")) item_collected = false;
if (!variable_instance_exists(id, "inspect_angle")) inspect_angle = 0;
if (!variable_instance_exists(id, "item_name")) item_name = "Item";
if (!variable_instance_exists(id, "inspect_model_scale")) inspect_model_scale = 1;
if (!variable_instance_exists(id, "inspect_model_xrot")) inspect_model_xrot = 0;
if (!variable_instance_exists(id, "inspect_model_yrot")) inspect_model_yrot = 0;
if (!variable_instance_exists(id, "inspect_model_zrot")) inspect_model_zrot = 0;
if (!variable_instance_exists(id, "inspect_camera_distance")) inspect_camera_distance = 32;
if (!variable_instance_exists(id, "inspect_camera_height")) inspect_camera_height = 10;
if (!variable_instance_exists(id, "inspect_camera_fov")) inspect_camera_fov = 35;
if (!variable_instance_exists(id, "inspect_model_fit_height")) inspect_model_fit_height = 0.34;
if (!variable_instance_exists(id, "inspect_model_auto_fit")) inspect_model_auto_fit = true;
if (!variable_instance_exists(id, "inspect_model_bounds_ready")) inspect_model_bounds_ready = false;
if (!variable_instance_exists(id, "inspect_model_center_x")) inspect_model_center_x = 0;
if (!variable_instance_exists(id, "inspect_model_center_y")) inspect_model_center_y = 0;
if (!variable_instance_exists(id, "inspect_model_center_z")) inspect_model_center_z = 0;
if (!variable_instance_exists(id, "inspect_model_radius")) inspect_model_radius = 1;
if (!variable_instance_exists(id, "inspect_surface")) inspect_surface = -1;

if (!item_collected && instance_exists(obj_cam) && instance_exists(obj_player) && is_struct(_cast_vbm) && VBM_Model_GetPrismCount(_cast_vbm) > 0) {
        var _dist = VBM_Model_CastRay(_cast_vbm, world, obj_cam.cam_x, obj_cam.cam_y, obj_cam.cam_z, obj_cam.look_x, obj_cam.look_y, obj_cam.look_z, 0, 360, VBM_LAYERMASKALL, VBM_LAYERMASKALL, _hit_pos, _hit_nrm);
        var dist = point_distance(x, y, obj_player.x, obj_player.y);

        if (!is_undefined(_dist) && dist <= 70) {
        draw_sprite(spr_interaction, image_index, global.res_w - 70, global.res_h - 70);
        }
}

if (show_item) {
        if (surface_exists(application_surface)) {
                var _blur_w = max(1, floor(g_width * blur_scale));
                var _blur_h = max(1, floor(g_height * blur_scale));

                if (!surface_exists(blur_surface) || surface_get_width(blur_surface) != _blur_w || surface_get_height(blur_surface) != _blur_h) {
                        if (surface_exists(blur_surface)) {
                                surface_free(blur_surface);
                }

                blur_surface = surface_create(_blur_w, _blur_h);
                }

                surface_set_target(blur_surface);
                draw_clear_alpha(c_black, 1);
                draw_surface_stretched(application_surface, 0, 0, _blur_w, _blur_h);
                surface_reset_target();

                gpu_set_tex_filter(true);
                draw_surface_stretched(blur_surface, 0, 0, g_width, g_height);
                gpu_set_tex_filter(false);
        }
        draw_set_color(c_black);
        draw_set_alpha(0.7);
        draw_rectangle(g_width, g_height, 0, 0, false);
        draw_set_alpha(1);

        var _draw_vbm = variable_instance_exists(id, "render_vbm") ? render_vbm : vbm;

        if (is_struct(_draw_vbm) && _draw_vbm.vertex_buffer != -1) {
                if (!inspect_model_bounds_ready) {
                        var _min_x = 1000000000;
                        var _min_y = 1000000000;
                        var _min_z = 1000000000;
                        var _max_x = -1000000000;
                        var _max_y = -1000000000;
                        var _max_z = -1000000000;
                        var _bounds_found = false;

                        for (var _mesh_i = 0; _mesh_i < array_length(_draw_vbm.meshdefs); _mesh_i++) {
                                var _mesh = _draw_vbm.meshdefs[_mesh_i];
                                if (_mesh.loop_count <= 0) continue;

                                _min_x = min(_min_x, _mesh.bounds[0][0]);
                                _min_y = min(_min_y, _mesh.bounds[0][1]);
                                _min_z = min(_min_z, _mesh.bounds[0][2]);
                                _max_x = max(_max_x, _mesh.bounds[1][0]);
                                _max_y = max(_max_y, _mesh.bounds[1][1]);
                                _max_z = max(_max_z, _mesh.bounds[1][2]);
                                _bounds_found = true;
                        }

                        if (_bounds_found) {
                                inspect_model_center_x = (_min_x + _max_x) * 0.5;
                                inspect_model_center_y = (_min_y + _max_y) * 0.5;
                                inspect_model_center_z = (_min_z + _max_z) * 0.5;
                                inspect_model_radius = max(0.01, max(_max_x - _min_x, max(_max_y - _min_y, _max_z - _min_z)) * 0.5);
                        }

                        inspect_model_bounds_ready = true;
                }

                var _old_view = matrix_get(matrix_view);
                var _old_proj = matrix_get(matrix_projection);

                var _camera_distance = max(1, inspect_camera_distance);
                var _preview_scale = max(0.01, inspect_model_scale);
                if (inspect_model_auto_fit) {
                        var _camera_length = sqrt(sqr(_camera_distance) + sqr(inspect_camera_height));
                        var _camera_span = _camera_length * 2 * tan(degtorad(inspect_camera_fov) * 0.5);
                        var _fit_scale = (_camera_span * inspect_model_fit_height) / (inspect_model_radius * 2);
                        _preview_scale *= _fit_scale;
                }
                var _center_world = matrix_build(
                        -inspect_model_center_x,
                        -inspect_model_center_y,
                        -inspect_model_center_z,
                        0,
                        0,
                        0,
                        1,
                        1,
                        1
                );
                var _spin_world = matrix_build(
                        0,
                        0,
                        0,
                        inspect_model_xrot,
                        inspect_model_yrot,
                        inspect_model_zrot + inspect_angle,
                        _preview_scale,
                        _preview_scale,
                        _preview_scale
                );
                var _preview_world = matrix_multiply(_center_world, _spin_world);

                if (surface_exists(inspect_surface)) {
                        surface_free(inspect_surface);
                }

                inspect_surface = surface_create(floor(g_width), floor(g_height));
                if (surface_exists(inspect_surface)) {
                        surface_set_target(inspect_surface);
                        draw_clear_alpha(c_black, 0);
                        matrix_set(matrix_view, matrix_build_lookat(0, -_camera_distance, inspect_camera_height, 0, 0, 0, 0, 0, -1));
                        matrix_set(matrix_projection, matrix_build_projection_perspective_fov(inspect_camera_fov, -g_width / g_height, 1, 500));
                        gpu_set_ztestenable(true);
                        gpu_set_zwriteenable(true);
                        gpu_set_cullmode(cull_noculling);
                        matrix_set(matrix_world, _preview_world);
                        VBM_Model_Submit(_draw_vbm, _preview_world, VBM_LAYERMASKALL, true);
                        surface_reset_target();
                        gpu_set_ztestenable(false);
                        gpu_set_zwriteenable(false);
                        gpu_set_cullmode(cull_noculling);
                        matrix_set(matrix_world, matrix_build_identity());
                        matrix_set(matrix_view, _old_view);
                        matrix_set(matrix_projection, _old_proj);
                        draw_surface_ext(inspect_surface, 0, g_height, 1, -1, 0, c_white, 1);
                        surface_free(inspect_surface);
                        inspect_surface = -1;
                }
        }

        draw_set_color(c_white);
        draw_set_font(fnt_arial);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(g_width * 0.5, g_height * 0.78, item_name);

        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
}

gpu_pop_state();
