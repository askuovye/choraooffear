function enemy_idle() {
    var _dist = point_distance(x, y, obj_player.x, obj_player.y);

    if (_dist <= detect_range) {
        state = EnemyState.CHASE;
    }
}

function enemy_chase() {
    var _dist = point_distance(x, y, obj_player.x, obj_player.y);

    if (_dist > detect_range) {
        state = EnemyState.IDLE;
        exit;
    }

    if (_dist <= attack_range) {
        state = EnemyState.ATTACK;
        exit;
    }

    var _dir = point_direction(x, y, obj_player.x, obj_player.y);

    x += lengthdir_x(move_speed, _dir);
    y += lengthdir_y(move_speed, _dir);

    image_angle = _dir;
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
    obj_player.hp -= 1;

    attack_cooldown = room_speed;
}

function enemy_hurt() {
    hurt_timer--;

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
