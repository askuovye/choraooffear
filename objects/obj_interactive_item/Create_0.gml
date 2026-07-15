/// @description Insert description here
// You can write your code in this editor

show_item = false;
item_collected = false;
item_name = "Item";
inspect_angle = 0;
inspect_model_scale = 1;
inspect_model_xrot = 90;
inspect_model_yrot = 0;
inspect_model_zrot = 0;

inspect_camera_distance = 32;
inspect_camera_height = 10;
inspect_camera_fov = 35;
inspect_model_fit_height = 0.34;
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

model = 0;
vbm = VBM_Model_Create();

world = matrix_build(x, y, 0, 0, 0, 0, 1, 1, 1);

var ok = VBM_Model_Open(vbm, model);
if (!ok) {
    show_debug_message("Falha ao Carregar Modelo");
}
