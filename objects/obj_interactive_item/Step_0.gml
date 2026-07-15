/// @description Insert description here
// You can write your code in this editor

var _cast_vbm = variable_instance_exists(id, "collision_vbm") ? collision_vbm : vbm;

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
if (!variable_instance_exists(id, "inspect_rotation_speed")) inspect_rotation_speed = 1.5;

if (show_item) {
    inspect_angle += inspect_rotation_speed;

    if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("E"))) {
        show_item = false;
        if (item_collected) {
            instance_destroy();
            exit;
        }
    }
}

if (instance_exists(obj_cam) && instance_exists(obj_player) && is_struct(_cast_vbm) && VBM_Model_GetPrismCount(_cast_vbm) > 0) {

    var _hit_pos = [0, 0, 0];
    var _hit_nrm = [0, 0, 0];

    var _dist = VBM_Model_CastRay(_cast_vbm, world, obj_cam.cam_x, obj_cam.cam_y, obj_cam.cam_z, obj_cam.look_x, obj_cam.look_y, obj_cam.look_z, 0, 360, VBM_LAYERMASKALL, VBM_LAYERMASKALL, _hit_pos, _hit_nrm);
    var dist = point_distance(x, y, obj_player.x, obj_player.y);

    if (!item_collected && !is_undefined(_dist) && dist <= 70) {
        show_debug_message("olhando para o item");
        if(!show_item && keyboard_check_pressed(ord("E"))) {
            item_collected = true;
			event_user(0);
			show_item = true;
            inspect_angle = 0;
        }
    }

}




