/// @description Insert description here
// You can write your code in this editor

sprite_idle = spr_gun;
sprite_shoot = spr_gun_shoot;
shoot_interval = 40;
shoot_time = 0;

offset_x = 0;
offset_y = 0;
shift_x = 0;
shift_y = 0;

function shoot() {
    sprite_index = sprite_shoot;
    image_index = 0;
}
