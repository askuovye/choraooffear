/// @description Insert description here
// You can write your code in this editor

if (!instance_exists(obj_player)){
    exit;
}

var _dir = point_direction(obj_player.x, obj_player.y, x, y);
var _angle_diff = angle_difference(_dir, direction);
_angle_diff /= 90;
_angle_diff = round(_angle_diff);

if (_angle_diff == 0) {
    sprite_index = sprite_front;
} else if (_angle_diff == 1) {
    sprite_index = sprite_right;
} else if (_angle_diff == -1) {
    sprite_index = sprite_left;
} else if (abs(_angle_diff) == 2) {
    sprite_index = sprite_down;
}
 
var _dist = distance_to_object(obj_player);
var _move_x = 0;
var _move_y = 0;
if (_dist > 100){
    direction += 4;
}else {
    direction = _dir - 180;
}

_move_x = lengthdir_x(move_speed, direction);
_move_y = lengthdir_y(move_speed, direction);

move_and_collide(_move_x, _move_y, [obj_solid, obj_player]);


