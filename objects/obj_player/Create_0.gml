camera_height = 24;
z = camera_height;

//stats
hp = 4;
hp_max = 4;
rank = 0;

// movimento sexy
move_speed = 2;
move_x = 0;
move_y = 0;

sens_x = 0.1;
sens_y = 0.1;

zspd = 0;
grav = -0.3;

jump_speed = 7;
jump_frames = 15;
jump_timer = 0;

_foot_z = z - camera_height;
ground_z = camera_height;
on_ground = true;

camera_height = 24;
player_height = 48;
player_radius = 5;

step_height = 12; 



// câmera separada (cria só se não existir na room)
if (!instance_exists(obj_cam)) {
    instance_create_depth(0, 0, 0, obj_cam);
}

// armado e preparado
gun = instance_create_depth(0, 0, 0, obj_gun);
hud = instance_create_depth(0, 0, 0, obj_hud);