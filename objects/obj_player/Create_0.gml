z = 24;

// movimento sexy
move_speed = 2;
move_x = 0;
move_y = 0;

// câmera separada (cria só se não existir na room)
if (!instance_exists(obj_cam)) {
    instance_create_depth(0, 0, 0, obj_cam);
}

// armado e preparado
gun = instance_create_depth(0, 0, 0, obj_gun);

