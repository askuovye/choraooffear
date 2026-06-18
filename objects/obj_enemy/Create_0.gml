enemy_z = 0;
enemy_height = 48;

sprite_front = 0;
sprite_right = 0;
sprite_left = 0;
sprite_down = 0;
sprite_dead = 0;

move_speed = 0;	

hp = 3;

state = EnemyState.IDLE;

move_speed = 1.5;
detect_range = 250;
attack_range = 32;

attack_cooldown = 0;
hurt_timer = 0;

function hit(_damage = 1) {
    hp -= _damage;
    hp -= 1;
    hurt_timer = 10;
    state = EnemyState.HURT;

    if (hp <= 0) {
        state = EnemyState.DEAD;
    }
    show_debug_message("ACERTOU E TOMOU DANO")
}
