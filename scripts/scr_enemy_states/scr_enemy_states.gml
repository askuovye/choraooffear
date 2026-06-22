enum EnemyState {
    IDLE,
    CHASE,
    ATTACK,
    HURT,
    DEAD
}

function enemy_idle() {
    var _dist = point_distance(x, y, obj_player.x, obj_player.y);

    if (_dist <= detect_range) {
        state = EnemyState.CHASE;
    }
    var _dist = distance_to_object(obj_player);
    _move_x = 0;
    _move_y = 0;

    direction += 4;

    _move_x = lengthdir_x(move_speed, direction);
    _move_y = lengthdir_y(move_speed, direction);

}

function enemy_chase() {
    var _dist = point_distance(x, y, obj_player.x, obj_player.y);
    var _dir = point_direction(obj_player.x, obj_player.y, x, y);

    if (_dist > detect_range) {
        state = EnemyState.IDLE;
        exit;
    }

    if (_dist <= attack_range) {
        state = EnemyState.ATTACK;
        exit;
    }
    _move_x = lengthdir_x(move_speed, direction);
    _move_y = lengthdir_y(move_speed, direction);

    sprite_index = sprite_front;
    direction = _dir - 180;
}

function enemy_attack() {
    var _dist = point_distance(x, y, obj_player.x, obj_player.y);
    if (_dist > attack_range) {
        state = EnemyState.CHASE;
        exit;
    }
    if (attack_cooldown > 0) {
        attack_cooldown--;
        exit;
    }
    _move_x = 0;
    _move_y = 0;
    obj_player.hp -= 1;

    attack_cooldown = room_speed;
}

function enemy_hurt() {
    hurt_timer--;

    _move_x = 0;
    _move_y = 0;

    if (hurt_timer <= 0) {
        state = EnemyState.CHASE;
    }
}

function enemy_dead() {
    instance_create_depth(x, y, depth, obj_enemy_dead, {
        sprite_index: sprite_dead
    });
    instance_destroy();
}
