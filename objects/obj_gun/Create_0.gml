/// @description Insert description here
// You can write your code in this editor

sprite_idle = spr_gun;
sprite_shoot = spr_gun_shoot;
shoot_interval = 40;
shoot_time = 0;
reloading_time = 0;
reloading_interval = 120;

ammo = 12;
ammo_max = 12;

offset_x = 0;
offset_y = 0;
offset_angle = 0;
shift_x = 0;
shift_y = 0;
shift_angle = 0;

recoil_x = 0;
recoil_y = 0;
recoil_angle = 0;

shake = 0;
shake_amount = 5;
shake_decay = 0.75;


function shoot() {
    sprite_index = sprite_shoot;
    image_index = 0;
}
