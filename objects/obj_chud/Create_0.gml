/// @description Insert description here
// You can write your code in this editor

event_inherited();

sprite_front = spr_enemy_front;
sprite_right = spr_enemy_right;
sprite_left = spr_enemy_left;
sprite_down = spr_enemy_right;

sprite_dead = spr_enemy_dead;

move_speed = 4;

hp = 3;

state = EnemyState.IDLE;

detect_range = 250;
attack_range = 32;

attack_cooldown = 0;
hurt_timer = 0;


