/// @description Insert description here
// You can write your code in this editor

sprite_front = 0;
sprite_right = 0;
sprite_left = 0;
sprite_down = 0;
sprite_dead = 0;

move_speed = 0;

hp = 3;

function hit() {
    hp--;
    if (hp <= 0){
        instance_create_depth(x, y, depth, obj_enemy_dead, {
            sprite_index: sprite_dead
        })
        instance_destroy();
    }
}