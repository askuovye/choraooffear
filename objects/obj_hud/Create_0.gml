/// @description Insert description here
// You can write your code in this editor

offset_x = 0;
offset_y = 0;
offset_angle = 0;
shift_x = 0;
shift_y = 0;
shift_angle = 0;

sprite_index = spr_phone;

_player = instance_find(obj_player, 0);
_gun = instance_find(obj_gun, 0);

function hud_iddle_rank() {
    image_index = 4;
    image_speed = 0;
}

function hud_low_rank() {
    image_speed = 0.5;
    if (image_index < 4) {
        image_index = 4;
    }
}

function hud_medium_rank() {
    image_index = 3;
    image_speed = 0;
}

function hud_high_rank() {
    image_index = 2;
    image_speed = 0;
}

function hud_extreme_rank() {
    image_speed = 0.5;
    if (image_index > 1) {
        image_index = 0;
    }
}