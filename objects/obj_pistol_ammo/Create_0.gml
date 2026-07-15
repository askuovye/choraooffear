/// @description Insert description here
// You can write your code in this editor

show_item = false;
item_collected = false;
item_name = "Handgun Ammo";
inspect_angle = 0;
inspect_model_scale = 1;
inspect_model_xrot = -90;
inspect_model_yrot = 0;
inspect_model_zrot = 0;
inspect_camera_distance = 32;
inspect_camera_height = 10;
inspect_camera_fov = 35;
inspect_model_fit_height = 0.36;
inspect_model_auto_fit = true;
inspect_rotation_speed = 1.5;
inspect_model_bounds_ready = false;
inspect_model_center_x = 0;
inspect_model_center_y = 0;
inspect_model_center_z = 0;
inspect_model_radius = 1;

inventory_open = false;
blur_surface = -1;
inspect_surface = -1;
blur_scale = 0.1;

render_model = "models/9mm.vbm";
collision_model = "models/9mm_collision.vbm";

render_vbm = VBM_Model_Create();
collision_vbm = VBM_Model_Create();

world = matrix_build(x, y, 0, -90, 0, 0, 10, 10, 10);

var render_ok = VBM_Model_Open(render_vbm, render_model);
if (!render_ok) {
    show_debug_message("Falha ao Carregar Modelo");
}

var collision_ok = VBM_Model_Open(collision_vbm, collision_model);
if (!collision_ok) {
    show_debug_message("Falha ao Carregar Colisao");
}
