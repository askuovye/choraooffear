/// @description Insert description here
// You can write your code in this editor

if (!instance_exists(obj_player)) {
    exit;
}

if (global.game_paused) {
    exit;
}

var _spd = point_distance(0, 0, obj_player.move_x, obj_player.move_y) / obj_player.move_speed;
var _sinewave = sin(current_time / 100);
var _offset_x = _sinewave * _spd * 10;


_sinewave = sin(current_time / 50);
var _offset_y = _sinewave * _spd * 10;

offset_x = lerp(offset_x, _offset_x, 0.2);
offset_y = lerp(offset_y, _offset_y, 0.2);


// movimento realista uhhhhh
var _shift_x = window_mouse_get_delta_x() * -2;
var _shift_y = window_mouse_get_delta_y() * -1;


shift_x = lerp(shift_x, _shift_x, 0.05);
shift_y = lerp(shift_y, _shift_y, 0.05);

recoil_x = lerp(recoil_x, 0, 0.18);
recoil_y = lerp(recoil_y, 0, 0.18);
recoil_angle = lerp(recoil_angle, 0, 0.16);

shake *= shake_decay;

offset_x += shift_x + recoil_x;
offset_y += shift_y + recoil_y;
offset_angle = recoil_angle;

//CHUMBO GROSSO
if (mouse_check_button_pressed(mb_left) && ammo_in_mag <= 0 && reloading_time <= 0) {
    shake = max(shake, 8);

    recoil_angle += random_range(-3, 3);
} 

if (mouse_check_button(mb_left) && shoot_time <= 0 && ammo_in_mag > 0 && reloading_time <= 0) {
    
    if (!instance_exists(obj_cam)) {
        exit;
    }

    var _cam = instance_find(obj_cam, 0);

    var _range = 1000;

    var _x1 = _cam.cam_x;
    var _y1 = _cam.cam_y;
    var _z1 = _cam.cam_z;

    var _x2 = _x1 + _cam.look_x * _range;
    var _y2 = _y1 + _cam.look_y * _range;
    var _z2 = _z1 + _cam.look_z * _range;

    shoot();
    shoot_time = shoot_interval;
    ammo_in_mag--;

    recoil_x += random_range(-2, 2);
    recoil_y += 12;
    recoil_angle += random_range(-4, 4);   
    shake = max(shake, 4);

    var _damage = 1;

    var _enemy = collision_line(_x1, _y1, _x2, _y2, obj_enemy, false, true);

    if (_enemy != noone) {
        var _hit_z = line_get_z_at_point(_x1, _y1, _z1, _x2, _y2, _z2, _enemy.x, _enemy.y);

        var _enemy_bottom = _enemy.enemy_z;
        var _enemy_top = _enemy.enemy_z + _enemy.enemy_height;

        if (_hit_z >= _enemy_bottom && _hit_z <= _enemy_top) {
            _x2 = _enemy.x;
            _y2 = _enemy.y;
            _z2 = _hit_z;

            _enemy.hit(_damage);
            show_debug_message("ACERTOU O INIMIGO");
        }
    }

    var _tr = instance_create_layer(0, 0, "Instances", obj_bullet);

    _tr.x1 = _x1;
    _tr.y1 = _y1;
    _tr.z1 = _z1;

    _tr.x2 = _x2;
    _tr.y2 = _y2;
    _tr.z2 = _z2;

    _tr.col = c_yellow;

}   
if (shoot_time > 0) {
    shoot_time--;
}

if (keyboard_check_pressed(ord("R")) && ammo_in_mag < ammo_max && reloading_time <= 0) {

    var _need = ammo_max - ammo_in_mag;
    var _available = obj_inventory_manager.inv.inventory_get_amount("Handgun Ammo");
    var _take = min(_need, _available);

    if (_take > 0) {
        obj_inventory_manager.inv.inventory_subtract_item("Handgun Ammo", _take);
        ammo_in_mag += _take;
        
        reloading_time = reloading_interval;
    }
}

if (shake < 0.05) {
    shake = 0;
}

if (reloading_time > 0) {
    reloading_time--;

    offset_y += 40;

    if (reloading_time <= 0) {
        ammo_in_mag = ammo_max;
    }
}
