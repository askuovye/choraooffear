/// @description Insert description here
// You can write your code in this editor

if (!dialog_active || !instance_exists(obj_cam) && !instance_exists(obj_player)) {
    exit;
}

if (dialog_active) {
    timer--;

    if (timer <= 0) {
        dialog_active = false;

        text = "";
        current_text = "";
    }
}


