/// @description Insert description here
// You can write your code in this editor

if (!instance_exists(obj_player)) {
    exit;
}

var _dir = obj_player.direction + 90;
var _matrix = matrix_build(x, y, 0, 90 + obj_player.tilt * z_tilt, 0, _dir, 1, 1, 1);
matrix_set(matrix_world, _matrix);
draw_sprite_ext(sprite_index, image_index, 0, 0, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
matrix_set(matrix_world, matrix_build_identity());



