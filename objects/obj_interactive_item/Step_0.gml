/// @description Insert description here
// You can write your code in this editor

var _cast_vbm = variable_instance_exists(id, "collision_vbm") ? collision_vbm : vbm;

if (instance_exists(obj_cam) && is_struct(_cast_vbm) && VBM_Model_GetPrismCount(_cast_vbm) > 0) {

    var _hit_pos = [0, 0, 0];
    var _hit_nrm = [0, 0, 0];

    var _dist = VBM_Model_CastRay(_cast_vbm, world, obj_cam.cam_x, obj_cam.cam_y, obj_cam.cam_z, obj_cam.look_x, obj_cam.look_y, obj_cam.look_z, 0, 360, VBM_LAYERMASKALL, VBM_LAYERMASKALL, _hit_pos, _hit_nrm);
    var dist = point_distance(x, y, obj_player.x, obj_player.y);

    if (!is_undefined(_dist) && dist <= 70) {
        show_debug_message("olhando para o item");
        if(keyboard_check_pressed(ord("E"))) {

        }
    }

}




